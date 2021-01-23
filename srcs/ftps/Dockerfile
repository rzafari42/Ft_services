FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk upgrade && \
    apk add openssl vsftpd --no-cache
    

RUN openssl req -x509 -days 365 -nodes -subj "/C=FR/ST=75/L=Paris/O=42/CN=rzafari_ft_service" \
    -newkey rsa:2048  -out /etc/ssl/certs/vsftpd.crt -keyout /etc/ssl/private/vsftpd.key

COPY ./hello.txt /home/hello.txt
COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./ftps.sh .
RUN chmod +x ./ftps.sh

EXPOSE 21 30000
ENTRYPOINT ./ftps.sh