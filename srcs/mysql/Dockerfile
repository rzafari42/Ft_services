FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add mysql mysql-client --no-cache

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
    
COPY ./my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY  ./mysql.sh .
COPY ./db_init.sh .

RUN mkdir -p /var/log/supervisor/
COPY ./supervisord.conf /etc/
RUN chmod +x ./mysql.sh
RUN chmod +x ./db_init.sh

EXPOSE 3306
ENTRYPOINT  ./mysql.sh