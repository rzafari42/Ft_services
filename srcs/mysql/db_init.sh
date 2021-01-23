#!/bin/sh

temp_file="/tmp/mysql_init"

#Setting password and grants to the admin then create database and set grants to the user.
echo > $temp_file
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

until mysql
do 
    sleep 0.5
done

#Apply the changes then remove the temporary file
mysql < $temp_file
rm $temp_file

exit
