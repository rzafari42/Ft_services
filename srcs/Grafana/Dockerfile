FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && \
    apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN mkdir -p /var/log/supervisor/

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY ./grafana.ini /usr/share/grafana/conf/custom.ini
COPY ./influxdb.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY ./dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/
COPY ./dashboards /var/lib/grafana/dashboards/
COPY ./supervisord.conf /etc/

COPY ./grafana.sh .
RUN chmod +x ./grafana.sh

EXPOSE 3000

ENTRYPOINT ./grafana.sh
