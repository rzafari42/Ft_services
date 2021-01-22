#!/bin/sh

temp_file=$(mktemp)

if [[$__MYSQL_ADMIN__ != $DB_USER]]
then
        echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';" >> $temp_file


#Setting password and grants to the admin then create database and set grants to the user.
#We also delete the 'test' database
cat <<EOF > $temp_file
RENAME USER 'mysql'@'localhost' to '$__MYSQL_ADMIN__'@'localhost';
SET PASSWORD FOR '$__MYSQL_ADMIN__'@'localhost'=PASSWORD('${__MYSQL_ADMIN_PASSWD__}');
GRANT ALL ON *.* TO '$__MYSQL_ADMIN__'@'127.0.0.1' IDENTIFIED BY '$__MYSQL_ADMIN_PASSWD__' WITH GRANT OPTION;
GRANT ALL ON *.* TO '$__MYSQL_ADMIN__'@'localhost' IDENTIFIED BY '$__MYSQL_ADMIN_PASSWD__' WITH GRANT OPTION;

CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;
GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;
GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'127.0.0.1' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;
DROP DATABASE test;
FLUSH PRIVILEGES;
EOF

until mysql
do 
    sleep 0.5
done

#Apply the changes then remove the temporary file
mysql < $temp_file
rm $temp_file

exit
