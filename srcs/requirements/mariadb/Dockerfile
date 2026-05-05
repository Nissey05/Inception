# FROM ubuntu:latest

# RUN apt-get update
# RUN apt-get install -y mariadb-server

# EXPOSE 3306

# LABEL version="1.0"
# LABEL descrption="MariaDB Server"

# HEALTHCHECK --start-period=5m \
# 	CMD mariadb -e 'SELECT @@datadir;' || exit 1

# CMD ["mariadbd"]

# Use the official MariaDB image as the base image

FROM mariadb:latest

# Set environment variables for MariaDB root password and database name

RUN apt-get update
RUN apt-get install -y mariadb-server

ENV MARIADB_ROOT_PASSWORD="pieter"

ENV MARIADB_DATABASE=my_database

# Copy the custom MariaDB configuration file into the container

COPY mariadb.conf /etc/mysql/conf.d/

# Copy initialization SQL scripts into the Docker container

COPY conf/ /docker-entrypoint-initdb.d/

# Expose the default MariaDB port

EXPOSE 3306

# Run the MariaDB server

CMD ["mysqld"]