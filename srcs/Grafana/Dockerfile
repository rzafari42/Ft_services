FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add grafana --repository http://dl-3.alpinelinux.org/alpine/edge/testing/



COPY ./grafana.ini /usr/share/grafana/conf/grafana.ini
COPY ./influxdb.yaml /usr/shae/grafana/conf/provisioning/datasources/
COPY ./dashboard.yaml /usr/share/grafana/conf/provisioning/dashboard
COPY ./dashboard /var/lib/grafana/dashboards/


COPY ./grafana.sh .
RUN chmod +x ./grafana.sh

EXPOSE 3000

ENTRYPOINT ./grafana.sh
