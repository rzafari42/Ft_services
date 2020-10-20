FROM alpine:latest

MAINTAINER = "rzafari rzafari@students.42.us.org"

RUN apk update && \
        apk add nginx && \
        apk add openssl
    # Onpenssl is a toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.
    # apk add openssh && \ 
    #SSH protocol uses encryption to secure the connection between a client and a server.
    
RUN adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www && \
    mkdir -p /run/nginx

RUN adduser -D user42
RUN echo "user42:password"|chpasswd

RUN openssl req -x509 -days 365 -newkey rsa:2048 -nodes -subj "/C=FR/ST=75/L=Paris/O=42/CN=rzafari_ft_service" \
    -keyout /etc/ssl/private/nginx-cert.key -out /etc/ssl/certs/nginx-cert.crt
COPY example.html /var/www/conf.d/default.conf

COPY nginx.conf /etc/nginx/sites-available/localhost
COPY setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

EXPOSE 80 443