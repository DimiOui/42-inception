#!/bin/bash

if [ ! -d "/var/lib/mysql/${MYSQL_DB}" ]; then

    /usr/bin/mysqld_safe --datadir=/var/lib/mysql &

    until mysqladmin ping; do
         sleep 2
    done

	mysql -u root << EOF
    CREATE DATABASE ${MYSQL_DB};
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* to '${MYSQL_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOF

    mysqladmin shutdown
fi

exec "$@"
