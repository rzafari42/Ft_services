FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add openssl vsftpd

RUN sudo openssl req -x509 -days 365 -nodes -subj "/C=FR/ST=75/L=Paris/O=42/CN=rzafari_ft_service" \
    -newkey rsa:2048  -out /etc/ssl/private/vsftpd.cert.pem -keyout /etc/ssl/private/vsftpd.key.pem

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21 30000