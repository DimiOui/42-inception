FROM	alpine:3.16

RUN		apk update
RUN		apk add --upgrad apk-tools && \
		apk upgrade --available

RUN		apk add mariadb-client \
		curl \
		bash \
		php8 \
		php8-dom \
		php8-fpm \
		php8-ftp \
		php8-gd \
		php8-iconv \
		php8-mbstring \
		php8-mongodb \
		php8-mysqli \
		php8-openssl \
		php8-phar \
		php8-zlib

RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp

COPY	tools/create_wp.sh /opt/create_wp.sh
RUN		chmod +x /opt/create_wp.sh

WORKDIR	/var/www/html/

EXPOSE 9000

CMD ["/opt/create_wp.sh"]
