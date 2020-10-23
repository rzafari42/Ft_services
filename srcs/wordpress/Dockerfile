FROM alpine:latest

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add nginx && \
    apk add php-fpm \
    php7-fpm \
    php7-json \
    php7-zlib \
    php7-xml \
    php7-pdo \
    php7-phar \
    php7-openssl \
    php7-pdo_mysql \
    php7-mysqli \
    php7-session \
    php7-gd \
    php7-iconv \
    php7-mcrypt \
    php7-curl \
    php7-opcache \
    php7-ctype \
    php7-apcu \
    php7-intl \
    php7-bcmath \
    php7-mbstring \
    php7-dom \
    php7-xmlreader \
    php7-simplexm \
    mysql-client

#We need to creat the folder /run/nginx to get nginx to work correctly so it can assign a PID number to the directory
RUN mkdir -p /run/nginx 
ENV WP_VERSION  5.5.1
ENV WP_FILE wordpress-${WP_VERSION}.tar.gz
ADD https://wordpress.org/${WP_FILE} .
RUN tar -xzvf ${WP_FILE} -C /var/www/ && \
    rm -rf ${WP_FILE}  \
    /var/www/wp-config-sample.php

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY worpress_config.php /var/www/wordpress/

EXPOSE 5050