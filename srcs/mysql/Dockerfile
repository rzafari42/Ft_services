FROM alpine:3.12.3

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && \
	apk add mariadb mariadb-client mariadb-common --no-cache

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community


RUN mkdir -p /var/log/supervisor/
COPY ./supervisord.conf /etc/

COPY wordpress.sql ./wordpress.sql
COPY mysql.sh ./mysql.sh
COPY ./my.cnf /etc/my.cnf.d/mariadb-server.cnf
RUN chmod +x ./mysql.sh

EXPOSE 3306
ENTRYPOINT ./mysql.sh
