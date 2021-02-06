#!/bin/sh

envsubst '$__CLUSTER_EXTERNAL_IP__' < /tmp/vsftpd.con > /etc/vsftpd/vsftpd.conf
{ echo "$GRAFANA_USER";echo "$GRAFANA_PASSWORD"; } | adduser $GRAFANA_USER

supervisord