#!/usr/bin/env zsh



kubectl delete --all deployment
kubectl delete --all svc
kubectl delete --all pods
kubectl delete --all statefulset
kubectl delete --all pvc
kubectl delete --all pv
kubectl delete --all secret

#Required to use driver none for kubernetes
if ! which conntrack &>/dev/null; then
	sudo apt-get install -y conntrack
fi


if ! kubectl version 2>/dev/null 1>&2 ; then
        service nginx stop       
        echo "Minikube is about to start !"
        sudo minikube start --driver=none  #driver none is required in any VM environment
fi

sudo chown -R user42 $HOME/.kube $HOME/.minikube

#################################################
####            METALLB                      ####
#################################################
echo "Metallb is about to be installed !"

# see what changes would be made, returns nonzero returncode if different
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

#Install MetalLB by Manifest
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl delete -f ./srcs/metallb-conf.yaml
kubectl apply -f ./srcs/metallb-conf.yaml

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
echo "LoadBalancer IP : ${IP}"


echo "Let's build every docker images ..."
echo "nginx ..."
docker build -t nginx srcs/nginx
echo "PhpMyAdmin..."
docker build -t PhpMyAdmin srcs/PhpMyAdmin
echo "Wordpress..."
docker build -t wordpress srcs/wordpress
echo "MySQL..."
docker build -t MySQL srcs/MySQL
echo "FTPS..."
docker build -t fts srcs/ftps
echo "Grafana..."
docker build -t grafana srcs/Grafana
echo "InfluxDB..."
docker build -t InfluxDB srcs/InfluxDB


DB_NAME=wordpress; DB_USER=wp_user; DB_PASSWORD=password; DB_HOST=mysql;

kubectl create secret generic db-id \
        --from-literal=name=${DB_NAME} \
        --from-literal=user=${DB_USER} \
        --from-literal=password=${DB_PASSWORD} \
        --from-literal=host=${DB_HOST}

kubectl create secret generic rzafari \
        --from-literal=user="rzafari" \
        --from-literal=password="password"
        
# Service deployment
echo "About to deploy services ..."
echo "Let start with nginx ..."
kubectl create -g ./srcs/nginx-deployment.yaml
echo "MySQL ..."
kubectl create -g ./srcs/mysql-deployment.yaml
echo "wordpress next..."
kubectl create -g ./srcs/wordpress-deployment.yaml
echo "then PhpMyAdmin ..."
kubectl create -g ./srcs/phpmyadmin-deployment.yaml
echo "and ftps ..."
kubectl create -g ./srcs/ftps-deployment.yaml
echo "but also influxdb ..."
kubectl create -g ./srcs/influxdb-deployment.yaml
echo "and finally Grafana ..."
#kubectl create -g ./srcs/grafana-deployment.yaml

# Dachboard
echo "Dashboard is about to be opened ..."
sudo minikube dashboard
