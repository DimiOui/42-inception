FROM alpine:3.16

RUN		apk update
RUN		apk add --upgrade apk-tools && \
		apk upgrade --available

RUN		apk add vsftpd

COPY	conf/vsftpd.conf /var/www/vsftpd.conf

COPY	tools/vsftpd_init.sh /var/www/vsftpd_init.sh
RUN		chmod +x /var/www/vsftpd_init.sh

CMD ["/var/www/vsftpd_init.sh"]

# ftp -p 127.0.0.1 to connect
