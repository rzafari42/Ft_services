FROM alpine:latest
LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add influxdb --no-cache

RUN mkdir -p /etc/influxdb/
RUN mkdir -p /var/log/supervisor/

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY ./influxdb.conf /etc/influxdb/influxdb.conf
COPY ./supervisord.conf /etc/supervisord.conf

COPY ./influxdb.sh .
RUN chmod +x ./influxdb.sh

EXPOSE 8086
ENTRYPOINT ./influxdb.sh
