FROM debian:buster

RUN apt-get update
RUN apt-get -y install nginx \
	openssl

RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/nginx_certificate.key \
		-out /etc/ssl/certs/nginx_certificate.crt \
		-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=localhost"

COPY conf/nginx.conf /etc/nginx/conf.d/

EXPOSE 433

CMD ["nginx", "-g", "daemon off;"]
