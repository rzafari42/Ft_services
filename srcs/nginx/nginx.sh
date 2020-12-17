#!/bin/sh

export  user=username
export  user_pass=;

adduser -D ${user};
echo "$user:$user_pass" | chpasswd

#supervisord
/usr/sbin/nginx -g 'daemon off;'