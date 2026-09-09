#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/wp-cli.pgp | gpg --import
gpg --verify wp-cli.phar.asc wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp --info

cd /var/www/html

rm -rf *

wp core download --allow-root

#change whats below this

wp config create \
	--dbname=${MYSQL_DATDABASE} \
	--dbuser=${MYSQL_USER} \
	--dbpass=${MYSQL_PASSWORD} \
	--dbhost=mariadb \
	--allow-root \
	--skip-check

wp core install \
	--url=${DOMAIN_NAME} \
	--title=${WP_TITLE} \
	--admin_user=${WP_ADMIN_USER} \
	--admin_password=${WP_ADMIN_PASSWORD} \
	--admin_email=${WP_ADMIN_EMAIL} \
	--allow-root

wp user create ${WP_USER} ${WP_USER_EMAIL} \
	--role=subscriber \
	--user_pass=${WP_USER_PASSWORD} \
	--allow-root

sed -i "s#listen = /run/php/php8.2-fpm.sock#listen = 0.0.0.0:9000#" /etc/php/8.2/fpm/pool.d/www.conf

exec php-fpm8.2 -F