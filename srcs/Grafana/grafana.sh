#!/bin/sh

sed s/__GRAFANA_USER__/$GRAFANA_USER/g /usr/share/grafana/conf/grafana.ini -i
sed s/__GRAFANA_PASSWORD__/$GRAFANA_PASSWORD/g /usr/share/grafana/conf/grafana.ini -i

supervisord