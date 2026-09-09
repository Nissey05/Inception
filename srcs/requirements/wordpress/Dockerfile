FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y php-mysql mariadb-client php8.2-fpm curl

COPY tools/start-wordpress.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/start-wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/start-wordpress.sh"]