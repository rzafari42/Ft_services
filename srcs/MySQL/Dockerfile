FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add mariadb maria-common mariadb-client openrc

COPY my.cnf /etc/mysql/mysql.conf.d
EXPOSE 3306