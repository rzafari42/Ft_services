FROM alpine:latest
LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add influxdb

RUN mkdir -p /etc/influxdb
COPY ./influxdb.conf /etc/influxdb/influxdb.conf

EXPOSE 8086

