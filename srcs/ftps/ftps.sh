#!/bin/sh

{ echo "$FTP_USERNAME";echo "$FTP_PASSWORD"; } | adduser $FTP_USERNAME

supervisord