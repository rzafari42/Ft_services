#!/bin/sh

mysql_install_db --datadir=/var/lib/mysql
sleep 5
mysqld --default-authentication-plugin=mysql_native_password &
sleep 5

tmp="/tmp/init.sql"

echo > $tmp \
"CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS ${DB_USER} IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

if [ ! -f /var/lib/mysql/wpNewUsers ]; then
    echo "done" >> /var/lib/mysql/wpNewUsers
    mysql -h localhost -e "$(cat $tmp)"
    mysql wordpress -u root < wordpress.sql
fi

mkdir -p /etc/telegraf
telegraf -sample-config --input-filter cpu:mem:net:swap:diskio --output-filter influxdb > /etc/telegraf/telegraf.conf
sed -i s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = ["http:\/\/influxdb:8086"]'/ /etc/telegraf/telegraf.conf
sed -i s/'# database = "telegraf"'/'database = "mysql"'/ /etc/telegraf/telegraf.conf
sed -i s/'omit_hostname = false'/'omit_hostname = true'/ /etc/telegraf/telegraf.conf


rm -f $tmp

/usr/shar/mariadb/mysql.server stop

mysqld --default-authentication-plugin=mysql_native_password &
telegraf &

while sleep 60; do 
    ps aux | grep telegraf | grep -q -v grep
    PROCESS_1_STATUS=$?
    ps aux | grep mysqld | grep -q -v grep
    PROCESS_2_STATUS=$?
    if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
        echo "One of the process has already exited."
        exit 1
    fi 
done