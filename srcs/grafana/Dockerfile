FROM alpine:3.12.3

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.13/community" >> /etc/apk/repositories
RUN apk update && \
    apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ --no-cache

RUN apk update && apk upgrade && apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ --no-cache

COPY ./grafana.ini /usr/share/grafana/conf/custom.ini
#COPY ./influxdb.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY ./dashboards/grafana.db /var/lib/grafana/data/

COPY ./grafana.sh .
RUN chmod +x ./grafana.sh

EXPOSE 3000

ENTRYPOINT ./grafana.sh