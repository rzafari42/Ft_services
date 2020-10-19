FROM alpine:latest

MAINTAINER = "rzafari rzafari@students.42.us.org"

RUN apk update && \
    apk add nginx && \
    apk add openssl && \ #toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.
    apk add openssh && \ #SSH protocol uses encryption to secure the connection between a client and a server.
    
RUN adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginxc && \
    chown -R www:www /www && \
    mkdir -p /run/nginx

RUN adduser -D user42 && \ 
    echo "User password:" | chpasswd && \
    ssh-keygen && \
    

COPY index.html /www/index.html
COPY nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

EXPOSE 80 443