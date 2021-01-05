#!/bin/sh

temp_file=$(mktemp)

#Setting password and grants to the admin then create database and set grants to the user.
#We also delete the 'test' database
cat <<EOF $temp_file
RENAME USER 'mysql'@'localhost' to '$__MYSQL_ADMIN__'@'localhost';
SET PASSWORD FOR '$'__MYSQL_ADMIN__'@'localhost'=PASSWORD('${__MYSQL_ADMIN_PASSWD__}');
GRANT ALL ON *.* TO '$__MYSQL_ADMIN__'@'127.0.0.1' IDENTIFIED BY '$__MYSQL_ADMIN_PASSWD__' WITH GRANT OPTION;
GRANT ALL ON *.* TO '$__MYSQL_ADMIN__'@'localhost' IDENTIFIED BY '$__MYSQL_ADMIN_PASSWD__' WITH GRANT OPTION;

CREATE DATABASE IF NOT EXISTS $__MYSQL_DB_NAME__ CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL ON $__MYSQL_DB_NAME__.* TO '$__MYSQL_DB_USER__'@'%' IDENTIFIED BY '$__MYSQL_DB_PASSWD__' WITH GRANT OPTION;
GRANT ALL ON $__MYSQL_DB_NAME__.* TO '$__MYSQL_DB_USER__'@'localhost' IDENTIFIED BY '$__MYSQL_DB_PASSWD__' WITH GRANT OPTION;
GRANT ALL ON $__MYSQL_DB_NAME__.* TO '$__MYSQL_DB_USER__'@'127.0.0.1' IDENTIFIED BY '$__MYSQL_DB_PASSWD__' WITH GRANT OPTION;
DROP DATABASE test;
FLUSH PRIVILEGES;
EOF

until mysql
do 
    sleep 0.5
done

#Apply the changes the remove the temporary file
mysql < $temp_file
rm $temp_file




