FROM debian:buster

RUN apt-get update
RUN apt-get install -y \
	mariadb-server \
	mariadb-client \
	mariadb-common

RUN mkdir -p /run/mysql /var/lib/mysql
RUN chown -R mysql:mysql /run/mysql /var/lib/mysql

RUN	mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/mariadb_init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_init.sh

ENTRYPOINT ["mariadb_init.sh"]

CMD ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql"]

EXPOSE 3306
