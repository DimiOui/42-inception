#!/bin/sh

if [ -f /var/www/html/wp-config.php ]
then
    echo "Wordpress is already installed"
else
	echo "Installing Wordpress"
	wp core download --allow-root
	wp core install http://wordpress.org/latest.tar.gz
	echo "Wordpress sucessfully installed"

	until	mysqladmin --user=${MYSQL_USER} \
			--password=${MYSQL_PASSWORD} \
			--host=mariadb ping; do
		sleep 2
	done

	wp config create	--dbname=${MYSQL_DB} \
						--dbuser=${MYSQL_USER} \
						--dbpass=${MYSQL_PASSWORD} \
						--dbhost=mariadb \
						--allow-root

	wp core install		--url=${DOMAIN_NAME} \
						--title=${WP_TITLE} \
						--admin_user=${WP_ADMIN} \
						--admin_password=${WP_ADMIN_PASSWORD} \
						--admin_email=${WP_ADMIN_EMAIL} \
						--skip-email \
						--allow-root

	wp user create 		${WP_USER} ${WP_USER_EMAIL} \
						--user_pass=${WP_USER_PASSWORD} \
						--role=author \
						--allow-root


	wp theme install "twentyseventeen" --activate --allow-root

	wp post generate	--count=1 \
						--post_author="dpaccagn" \
						--post_title="Hello World" \
						--post_content="This is my first post" \
						--post_status=publish \
						--allow-root

fi

exec "$@"
