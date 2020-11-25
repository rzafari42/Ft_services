FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update

RUN wget https://dl.grafana.com/oss/release/grafana-7.3.4.linux-amd64.tar.gz && \
    tar -zxvf grafana-7.3.4.linux-amd64.tar.gz && \
    mv grafana-7.3.4 && \
    rm -rf grafana-7.3.4.linux-amd64.tar.gz

COPY ./grafana.ini /etc/grafana/grafana.ini
#To finish 

EXPOSE 3000