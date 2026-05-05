FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y mariadb-server

EXPOSE 3306

LABEL version="1.0"
LABEL descrption="MariaDB Server"

HEALTHCHECK --start-period=5m \
	CMD mariadb -e 'SELECT @@datadir;' || exit 1

COPY conf/mariadb.conf /etc/mysql/mariadb.conf
COPY conf/init-db.sql /docker-entrypoint-initdb.d/
COPY start-mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-mariadb.sh

CMD ["/usr/local/bin/start-mariadb.sh"]
