#!/bin/bash

CONF=/etc/nginx/nginx.conf
SSL_DIR=/etc/nginx/ssl
SSL_CERT=$SSL_DIR/inception.crt
SSL_KEY=$SSL_DIR/inception.key

# Substitute environment variables into the nginx config
if [ -f "$CONF" ]; then
	sed -i \
		-e "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" \
		$CONF
fi

# Generate a self-signed SSL certificate if it doesn't already exist
if [ ! -f "$SSL_CERT" ] || [ ! -f "$SSL_KEY" ]; then
	mkdir -p $SSL_DIR
	openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 \
		-keyout $SSL_KEY \
		-out $SSL_CERT \
		-subj "/C=NL/ST=ZH/L=City/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

# Start nginx in the foreground
exec nginx -g "daemon off;"