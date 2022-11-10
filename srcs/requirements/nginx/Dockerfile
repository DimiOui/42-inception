FROM alpine:3.16

RUN		apk update
RUN		apk add --upgrade apk-tools && \
		apk upgrade --available

RUN		apk add nginx \
		openssl \
		php8-fpm

RUN		adduser -D -g 'www' www
RUN		mkdir /www && \
		chown -R www:www /var/lib/nginx && \
		chown -R www:www /www

RUN		openssl req -sha256 -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /var/lib/nginx/nginx_key.key \
		-out /var/lib/nginx/nginx_cert.pem \
		-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=student/CN=localhost"

COPY	conf/nginx.conf /etc/nginx/nginx.conf
ARG		DOMAIN_NAME

EXPOSE 433

CMD ["nginx", "-g", "daemon off;"]
