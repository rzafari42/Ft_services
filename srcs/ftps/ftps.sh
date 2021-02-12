#!/bin/sh

export FTPS_USER=rzafari;
export FTPS_PASSWORD=password;

echo -e "$FTPS_PASSWORD\n$FTPS_PASSWORD" | adduser -h /mnt/ftp $FTPS_USER

supervisord