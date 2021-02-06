#FROM alpine:3.12.3

#LABEL maintainer="rzafari <rzafari@students.42.us.org>"

#RUN apk update && \
#    apk upgrade && \
#    apk add openssl vsftpd --no-cache
    

#RUN openssl req -x509 -days 365 -nodes -subj "/C=FR/ST=75/L=Paris/O=42/CN=rzafari_ft_service" \
#    -newkey rsa:2048  -out /etc/ssl/certs/vsftpd.crt -keyout /etc/ssl/private/vsftpd.key

#RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
#    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
    
#COPY ./hello.txt /home/hello.txt
#COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
#COPY ./supervisord.conf /etc/
#COPY ./ftps.sh .
#RUN chmod +x ./ftps.sh

#EXPOSE 21 30000
#ENTRYPOINT ./ftps.sh**FROM alpine:3.12.3

FROM alpine:3.12.3

WORKDIR /tmp

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && apk add mariadb mariadb-common mariadb-client openrc --no-cache

COPY ./supervisord.conf /etc/
COPY ./my.cnf /etc/my.cnf.d/mariadb-server.cnf
# COPY ./users.sql .
# COPY ./wordpress.sql .

RUN rmdir /var/lib/mysql/
RUN mkdir -p /var/log/supervisor/

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

EXPOSE 3306

COPY wordpress.sql ./mysql.sql
COPY mysql.sh ./mysql.sh
RUN chmod +x ./mysql.sh
ENTRYPOINT ./mysql.sh