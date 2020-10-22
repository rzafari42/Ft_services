#!/bin/sh

sudo apt-get install -y conntrack

if ! kubectl version &> /dev/null; then
        service nginx stop
       # sudo minikube start --driver=none
        echo "Minikube ..."
fi

echo "About to build images ..."
docker build -t nginx srcs/nginx