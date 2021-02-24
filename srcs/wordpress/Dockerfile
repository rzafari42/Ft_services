FROM alpine:3.12.3

LABEL maintainer="rzafari <rzafari@students.42.us.org>"

RUN apk update && \
    apk add --no-cache nginx && \
    apk add openssl && \
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
    php7-simplexml \
    php7-xmlreader \
    mysql-client

#We need to creat the folder /run/nginx to get nginx to work correctly so it can assign a PID number to the directory
RUN mkdir -p /run/nginx/

ARG WP_FILE="wordpress-5.5.tar.gz"
RUN wget https://wordpress.org/${WP_FILE} && \
    tar -xf ${WP_FILE} && \
    mv wordpress /var/www/

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community


COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./wp_config.php /var/www/wordpress/wp-config.php

RUN mkdir -p /var/log/supervisor/
COPY ./supervisord.conf /etc/
COPY wp.sh ./wp.sh
RUN chmod +x ./wp.sh

EXPOSE 5050
#ENTRYPOINT ./wp.sh
CMD ["./wp.sh"]