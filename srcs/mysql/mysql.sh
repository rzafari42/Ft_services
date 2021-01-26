#!/bin/sh

mkdir -p /run/mysqld && \
chown -R mysql:mysql /run/mysqld


mysql_install_db --user=mysql --datadir=/var/lib/mysql/ #it creates the data directory and build the tables

#launching the scrip which create the wordpress database and the user (all of that in the background)
nohup db_init.sh &#>/dev/null 2>&1 &

#Starting mysqld. mysqld_safe ensures that the mysqld daemon restart in case of crash
/usr/bin/mysqld_safe --datadir="/var/lib/mysql/"
cd '/usr/mysql-test' ; perl mysql-test-run.pl

supervisord