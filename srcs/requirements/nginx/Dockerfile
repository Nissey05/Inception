FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
	nginx \
	openssl\
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 443

LABEL version="1.0"
LABEL description="Nginx Server"

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY start-nginx.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-nginx.sh

ENTRYPOINT ["/usr/local/bin/start-nginx.sh"]