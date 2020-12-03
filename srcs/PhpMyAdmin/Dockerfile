FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add lighttpd \
    php7-common \
    php7-iconv \
    php7-json \
    php7-gd \
    php7-curl \
    php7-xml \
    php7-mysqli \
    php7-imap \
    php7-cgi \
    fcgi \
    php7-pdo \
    php7-pdo_mysql \
    php7-soap \
    php7-xmlrpc \
    php7-posix \
    php7-mcrypt \
    php7-gettext \
    php7-ldap \
    php7-ctype \
    php7-dom

RUN mkdir -p /run/nginx 

ENV PHPMYADMIN_VERSION 5.0.2
ENV PHPMYADMIN_FILE phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz
ADD http://files.directadmin.com/services/all/phpMyAdmin/${PHPMYADMIN_FILE} .
RUN tar -xf ${PHPMYADMIN_FILE} && \
    mv ${PHPMYADMIN_FILE} /var/www/phpmyadmin && \
    rm -rf s$(PHPMYADMIN_FILE) 
    
RUN apk update && apk upgrade && apk add --no-cahce vim supervisor wget curl

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY Mypma_config.php /var/www/phpMyAdmin/config.inc.php

EXPOSE 5000

COPY ./supervisord.conf /etc/supervisord.conf

COPY ./Mypma.sh  .
ENTRYPOINT ./Mypma.sh