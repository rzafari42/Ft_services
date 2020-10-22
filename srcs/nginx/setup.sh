#!/bin/sh

service nginx stop
echo "Welcome"
docker build -t test .
echo "startting nginx"
service nginx start
echo "lets run it"
docker run -itd -p 443:443 test
echo "running"

#tail -f /dev/null