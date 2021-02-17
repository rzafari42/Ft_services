FROM alpine:3.12.3

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && apk add nginx --no-cache \
	php7-fpm php7-mcrypt php7-session php7-soap php7-openssl php7-gmp \
	php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli \
	php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc \
	php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader \
	php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype \
	php7-opcache php7-zlib php7-common php7-iconv php7-xml php7-imap php7-cgi \
	fcgi php7-posix php7-ldap php7-mbstring openssl

RUN mkdir -p /run/nginx/

ARG PMA_FILE="phpMyAdmin-5.0.2-all-languages"
RUN wget http://files.directadmin.com/services/all/phpMyAdmin/${PMA_FILE}.tar.gz && \
    tar -xf ${PMA_FILE}.tar.gz && \
    mv ${PMA_FILE} /var/www/phpmyadmin && \
    rm -rf $(PMA_FILE)
    
RUN openssl req -x509 -days 365 -newkey rsa:2048 -nodes -subj "/C=FR/ST=75/L=Paris/O=42/CN=rzafari_ft_service" \
    -keyout /etc/nginx/ssl/nginx-cert.key -out /etc/nginx/ssl/nginx-cert.crt

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./Mypma_config.php /var/www/phpmyadmin/config.inc.php

#RUN mkdir -p /var/log/supervisor/
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./Mypma.sh  .
RUN chmod +x ./Mypma.sh

EXPOSE 5000
ENTRYPOINT ./Mypma.sh