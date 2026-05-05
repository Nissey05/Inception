#!/bin/bash

# Initialize MariaDB if needed
if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Run initialization SQL if it exists
if [ -f /docker-entrypoint-initdb.d/init-db.sql ]; then
    # Start mariadbd in the background temporarily for initialization
    mariadbd --user=mysql --datadir=/var/lib/mysql &
    MARIADB_PID=$!
    
    # Wait for MariaDB to start
    for i in {1..30}; do
        if mariadb -e 'SELECT 1' >/dev/null 2>&1; then
            echo "MariaDB is ready"
            break
        fi
        echo "Waiting for MariaDB... ($i/30)"
        sleep 1
    done
    
    # Run initialization SQL
    mariadb < /docker-entrypoint-initdb.d/init-db.sql
    
    # Stop the background instance
    kill $MARIADB_PID
    wait $MARIADB_PID 2>/dev/null
fi

# Start MariaDB in the foreground with config
exec mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
