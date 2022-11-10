#!/bin/sh

#Configuring php-fpm
echo "listen = 9000 " >> /etc/php8/php-fpm.d/www.conf
sed -i "s/;error_log/error_log/" /etc/php8/php-fpm.conf
ln -sf /dev/stderr /var/log/php8/error.log

#Waiting for Mariadb
while ! mariadb -h${MYSQL_HOSTNAME} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DB} > /dev/null;
do
	sleep 2
done

if [ ! -f "index.php" ]
then
	#Installing Wordpress
	wp core download	--path="/var/www/html"
	wp config create	--dbname=${MYSQL_DB} \
						--dbuser=${MYSQL_USER} \
						--dbpass=${MYSQL_PASSWORD} \
						--dbhost=${MYSQL_HOSTNAME} \
						--allow-root
	if [ ! -f "wp-config.php" ]
	then
		return 1
	fi
	wp core install		--url="dpaccagn.42.fr" \
						--title=${WP_TITLE} \
						--admin_user=${WP_ADMIN} \
						--admin_password=${WP_ADMIN_PASSWORD} \
						--admin_email=${WP_ADMIN_EMAIL} \
						--skip-email \
						--allow-root

	wp user create 		${WP_USER} ${WP_USER_EMAIL} \
						--user_pass=${WP_USER_PASSWORD} \
						--role=author \

	wp theme install "twentyseventeen" --activate --allow-root

	wp search-replace 'http://dpaccagn.42.fr' 'https://dpaccagn.42.fr' > /dev/null

	wp post generate	--count=1 \
						--post_author="dpaccagn" \
						--post_title="I N C E P T I O N" \
						--post_content="Get inceptioned" \
						--post_status=publish \
						--allow-root

fi
echo "Running php-fpm" && php-fpm8 -FR
