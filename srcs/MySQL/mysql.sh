#!/bin/sh

mkdir -p /run/mysqld && \
chown -R mysql:mysql /run/mysqld

mysql_install_db --user=mysql --datadir=/var/lib/mysql/ #it creates the data directory and build the tables

db_init.sh & #launching the scrip which create the wordpress database and the user (all of that in the background)

#Starting mysqld. mysqld_safe ensures that the mysqld daemon restart in case of crash
/usr/bin/mysqld_safe --datadir="/var/lib/mysql/"