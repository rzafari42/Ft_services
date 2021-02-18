#!/bin/sh

sed s/__GRAFANA_USER__/$GRAFANA_USER/g /usr/share/grafana/conf/custom.ini -i
sed s/__GRAFANA_PASSWORD__/$GRAFANA_PASSWORD/g /usr/share/grafana/conf/custom.ini -i

mkdir -p /etc/telegraf
telegraf -sample-config --input-filter cpu:mem:net:swap:diskio --output-filter influxdb > /etc/telegraf/telegraf.conf
sed -i s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = ["http:\/\/influxdb:8086"]'/ /etc/telegraf/telegraf.conf
sed -i s/'# database = "telegraf"'/'database = "grafana"'/ /etc/telegraf/telegraf.conf
sed -i s/'omit_hostname = false'/'omit_hostname = true'/ /etc/telegraf/telegraf.conf

supervisord