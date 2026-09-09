#!/bin/bash

DATADIR=/var/lib/mysql
INITDB=/docker-entrypoint-initdb.d/init-db.sql

# Prepare initialization database with environment variable substitution
if [ -f /docker-entrypoint-initdb.d/init-db.sql ]; then
	sed -i \
		-e "s/__MYSQL_DATABASE__/${MYSQL_DATABASE}/g" \
		-e "s/__MYSQL_USER__/${MYSQL_USER}/g" \
		-e "s/__MYSQL_PASSWORD__/${MYSQL_PASSWORD}/g" \
		-e "s/__MYSQL_ROOT_PASSWORD__/${MYSQL_ROOT_PASSWORD}/g" \
		$INITDB
	
	# Initialize database directory if it doesn't exist
	if [ ! -d "${DATADIR}/${MYSQL_DATABASE}" ]; then
		mariadb-install-db --user=mysql --datadir=$DATADIR
		# Use init-file to run SQL during startup
		exec mariadbd --user=mysql --datadir=$DATADIR --init-file=$INITDB
	fi
fi

# Start MariaDB in the foreground
exec mariadbd --user=mysql --datadir=$DATADIR
