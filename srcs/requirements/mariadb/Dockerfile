FROM alpine:3.16

RUN apk update
RUN apk add --upgrade apk-tools && \
	apk upgrade --available

RUN apk add	mariadb \
	mariadb-client \
	mariadb-server-utils \
	bash

COPY tools/mariadb_init.sh mariadb_init.sh
RUN chmod +x mariadb_init.sh

RUN mkdir -p /var/lib/mysql/data
RUN chown -R mysql:mysql /var/lib/mysql/data

COPY conf/my.cnf /etc/mysql/my.cnf
COPY conf/my.cnf /etc/my.cnf

EXPOSE 3306

CMD ["./mariadb_init.sh"]

