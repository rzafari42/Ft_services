FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add mysql mysql-client
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld
#Setting the Database user and the mysql admin login/password
ENV __MYSQL_DB_NAME__ =wordpress
ENV __MYSQL_DB_USER__ =user42
ENV __MYSQL_DB_PASSWD_=user42
ENV __MYSQL_ADMIN__=user42
ENV __MYSQL_ADMIN_PASSWD__=user42

COPY ./my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY  ./mysql.sh ./
#RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql/

EXPOSE 3306
ENTRYPOINT  ./mysql.sh