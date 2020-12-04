FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add mariadb mariadb-common mariadb-client openrc --no-cache

COPY ./my.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN apk update && apk upgrade && apk add --no-cahce vim supervisor wget curl && \
    apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing


EXPOSE 3306

COPY ./supervisord.conf /etc/supervisord.conf
COPY ./telegraf.conf /etc/
COPY ./mysql.sh .
ENTRYPOINT  ./mysql.sh