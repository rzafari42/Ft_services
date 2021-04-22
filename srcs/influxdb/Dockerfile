FROM alpine:3.12.0

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add influxdb --no-cache

RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY influxdb.sh /usr/sbin/entrypoint.sh

EXPOSE 8086
ENTRYPOINT ["/usr/sbin/entrypoint.sh"]