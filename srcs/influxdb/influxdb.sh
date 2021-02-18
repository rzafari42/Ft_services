#!/bin/sh

#sed s/influxdb:8086/localhost:8086/g /etc/telegraf.conf -i

mkdir -p /etc/telegraf
telegraf -sample-config --input-filter cpu:mem:net:swap:diskio --output-filter influxdb > /etc/telegraf/telegraf.conf
sed -i s/'# database = "telegraf"'/'database = "influxdb"'/ /etc/telegraf/telegraf.conf
sed -i s/'omit_hostname = false'/'omit_hostname = true'/ /etc/telegraf/telegraf.conf

supervisord