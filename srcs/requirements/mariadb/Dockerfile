FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

LABEL version="1.0"
LABEL descrption="MariaDB Server"

RUN mkdir -p /var/lib/mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld && \
	chmod 777 /run/mysqld

HEALTHCHECK --start-period=10s --interval=5s --timeout=3s --retries=3 \
	CMD test -S /run/mysqld/mysqld.sock || exit 1

COPY conf/mariadb.conf /etc/mysql/mariadb.conf
COPY conf/init-db.sql /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/
COPY start-mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-mariadb.sh

CMD ["/usr/local/bin/start-mariadb.sh"]
