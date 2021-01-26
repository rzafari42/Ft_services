FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add nginx && \
    apk add openssl
    #Onpenssl is a toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.

RUN mkdir var/run/nginx && \
    mkdir -p /www
    
COPY ./index.html /www

RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -days 365 -newkey rsa:2048 -nodes -subj "/C=FR/ST=75/L=Paris/O=42/CN=rzafari_ft_service" \
    -keyout /etc/nginx/ssl/nginx-cert.key -out /etc/nginx/ssl/nginx-cert.crt

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN rm /etc/nginx/nginx.conf
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/log/supervisor/
COPY ./supervisord.conf /etc/
COPY nginx.sh .
RUN chmod +x nginx.sh

EXPOSE 80 443 
ENTRYPOINT ./nginx.sh
