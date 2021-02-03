#!/bin/sh

mysql_install_db --datadir=/var/lib/mysql
sleep 5

tmp="/tmp/init.sql"

echo > $tmp \
"CREATE DATABASE IF NOT EXIST ${DB_NAME};
CREATE USER IF NOT EXISTS ${DB_USER} IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* to '${DB_USER}'@'%';
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

if [ ! -f /var/lib/mysql/wpNewUsers ]; then
    echo "done" >> /var/lib/mysql/wpNewUsers
    mysql -h localhost -e "$(cat $tmp)"
    mysql -h localhost -e "$(cat ./wordpress.sql)"
fi

rm -f $tmp

/usr/shar/mariadb/mysql.server stop

supervisord
