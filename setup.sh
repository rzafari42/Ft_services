#!/usr/bin/env zsh

if ! which conntrack &>/dev/null; then
        sudo apt-get install -y conntrack
fi 

if ! kubectl version 2>/dev/null 1>&2 ; then
        service nginx stop
        sudo minikube start --driver=none
fi

sudo chown -R $USER $HOME/.kube $HOME/.minikube
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

#Install MetalLB by Manifestsssss
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb-conf.yaml
#Catch the LB IP and print it
LB_IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
echo "LoadBalancer IP : ${LB_IP}"

##################################################

services=(wordpress mysql nginx phpmyadmin grafana influxdb ftps)

#Set values for Database infos
DB_NAME=Wordpress; DB_HOST=mysql; DB_USER=rzafari; DB_PASSWORD=rzafari;
###################################################
#Create the necessary secrets
echo "Creating secrets..."
kubectl create secret generic db-user-pass \
        --from-literal=name=${DB_NAME} \
        --from-literal=host=${DB_HOST} \
        --from-literal=user=${DB_USER} \
        --from-literal=password=${DB_PASSWORD}

kubectl create secret generic user \
        --from-literal=user=rzafari \
        --from-literal=password=idontknwo
echo "Secret created"
###################################################

#Let's build and deploy our services
echo ""
for service in $services
do
        echo "Building $service"
        docker build --tag $service-img ./srcs/$service/ >/dev/null
        echo "Deploying $service"
        kubectl apply -f ./srcs/$service-deployment.yaml
done


sudo minikube dashboard