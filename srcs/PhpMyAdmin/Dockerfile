FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && apk add --no-cache nginx \
	php7-fpm php7-mcrypt php7-session php7-soap php7-openssl php7-gmp \
	php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli \
	php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc \
	php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader \
	php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype \
	php7-opcache php7-zlib php7-common php7-iconv php7-xml php7-imap php7-cgi \
	fcgi php7-posix php7-ldap php7-mbstring

RUN mkdir -p /run/nginx/

ARG PMA_VERSION=5.0.2
ARG PMA_FILE="phpMyAdmin-${PMA_VERSION}-all-languages"
RUN wget http://files.directadmin.com/services/all/phpMyAdmin/${PMA_FILE}.tar.gz && \
    tar -xf ${PMA_FILE}.tar.gz && \
    mv ${PMA_FILE} /var/www/phpMyAdmin && \
    rm -rf $(PMA_FILE)
    
RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./Mypma_config.php /var/www/phpMyAdmin/config.inc.php

EXPOSE 5000

COPY ./supervisord.conf /etc/supervisord.conf

COPY ./Mypma.sh  .
RUN chmod +x ./Mypma.sh
ENTRYPOINT ./Mypma.sh