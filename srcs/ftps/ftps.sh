#!/bin/sh

export FTPS_USER=rzafari;
export FTPS_PASSWORD=password;

echo -e "$FTPS_PASSWORD\n$FTPS_PASSWORD" | adduser -h /mnt/ftp $FTPS_USER

mkdir -p /etc/telegraf
telegraf -sample-config --input-filter cpu:mem:net:swap:diskio --output-filter influxdb > /etc/telegraf/telegraf.conf
sed -i s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = ["http:\/\/influxdb:8086"]'/ /etc/telegraf/telegraf.conf
sed -i s/'# database = "telegraf"'/'database = "ftps"'/ /etc/telegraf/telegraf.conf
sed -i s/'omit_hostname = false'/'omit_hostname = true'/ /etc/telegraf/telegraf.conf


supervisord