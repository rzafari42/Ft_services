#!/bin/sh

adduser -D $FTP_USERNAME && echo "$FTP_USERNAME:$FTP_PASSWORD"
 
usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf