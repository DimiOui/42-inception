FROM	debian:buster

RUN		apt-get update
RUN		apt-get install -y mariadb-client \
		curl \
		wget \
		php7.3 \
		php7.3-fpm \
		php7.3-curl \
		php7.3-mysql \
		php7.3-mbstring \
		php7.3-xml

RUN		mkdir -p /var/www/html ; mkdir -p /run/php

COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d

RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp

COPY	./tools/create_wp.sh /usr/local/bin/
RUN		chmod +x /usr/local/bin/create_wp.sh

ENTRYPOINT ["create_wp.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
