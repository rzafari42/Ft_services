FROM alpine:3.12.3

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk upgrade && \
    apk add openssl vsftpd --no-cache
    
ENV __CLUSTER_EXTERNAL_IP__=172.17.0.2
RUN openssl req -x509 -days 365 -nodes -subj "/C=FR/ST=75/L=Paris/O=42/CN=rzafari_ft_service" \
    -newkey rsa:2048  -out /etc/ssl/certs/vsftpd.crt -keyout /etc/ssl/private/vsftpd.key

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
    
COPY ./hello.txt /home/hello.txt
COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./supervisord.conf /etc/
COPY ./ftps.sh .
RUN chmod +x ./ftps.sh

EXPOSE 21 30000
ENTRYPOINT ./ftps.sh