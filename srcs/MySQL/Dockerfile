FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add mysql mysql-client --no-cache


#Setting the Database user and the mysql admin login/password
ENV __MYSQL_DB_NAME__ =wordpress
ENV __MYSQL_DB_USER__ =user42
ENV __MYSQL_DB_PASSWD_=user42
ENV __MYSQL_ADMIN__=user42
ENV __MYSQL_ADMIN_PASSWD__=user42

COPY ./mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY  ./mysql.sh . 
COPY ./db_init.sh .


RUN chmod +x ./mysql.sh
RUN chmod +x ./db_init.sh
EXPOSE 3306
ENTRYPOINT  ./mysql.sh