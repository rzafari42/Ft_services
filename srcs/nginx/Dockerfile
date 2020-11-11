FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add nginx && \
    apk add openssl
    #Onpenssl is a toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.

COPY nginx.conf /etc/nginx/sites-available/localhost
RUN mkdir /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

COPY index.html /var/www/index.html

#Certificate and public key
RUN openssl req -x509 -days 365 -newkey rsa:2048 -nodes -subj "/C=FR/ST=75/L=Paris/O=42/CN=rzafari_ft_service" \
    -keyout /etc/ssl/private/nginx-cert.key -out /etc/ssl/certs/nginx-cert.crt

CMD  nginx stop && \
    snginx start
EXPOSE 80 443
