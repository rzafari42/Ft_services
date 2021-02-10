#!/usr/bin/env zsh

if ! which conntrack &>/dev/null; then
    sudo apt-get install -y conntrack
fi

if ! kubectl version &>/dev/null; then
    sudo service nginx stop
    echo "Starting minikube..."
    sudo minikube start --driver=none
fi

sudo chown -R user42 $HOME/.kube $HOME/.minikube


echo "Let's delete some old things ..."
kubectl delete --all deployment
kubectl delete --all svc
kubectl delete --all pods
kubectl delete --all statefulset
kubectl delete --all pvc
kubectl delete --all pv
kubectl delete --all secret



# see what changes would be made, returns nonzero returncode if different
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

#Install MetalLB by Manifests
echo "Installing MetalLB ..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist \
--from-literal=secretkey="$(openssl rand -base64 128)"
kubectl delete -f ./srcs/metallb-conf.yaml; kubectl apply -f ./srcs/metallb-conf.yaml
#Catch the LB IP and print it
IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
echo "IP : ${IP}"

kubectl apply -k ./srcs/
#Set values for Database infos
echo "Let's build the images ..."
services=(nginx ftps mysql phpmyadmin wordpress grafana influxdb)

for service in $services
do
    docker build -t $service-img srcs/$service 2>/dev/null 1>&2
done
echo "Images are built !"

DB_NAME=wordpress; DB_USER=wp_user; DB_PASSWORD=password; DB_HOST=mysql;

echo "Let's build the secrets ..."
kubectl create secret generic db-id-user \
        --from-literal=name=${DB_NAME} \
        --from-literal=user=${DB_USER} \
        --from-literal=password=${DB_PASSWORD} \
        --from-literal=host=${DB_HOST}

kubectl create secret generic rzafari \
   --from-literal=user="rzafari" \
   --from-literal=password="idontknow"
echo "Secrets are built !"

services=(nginx ftps mysql phpmyadmin wordpress grafana influxdb)

echo "Let's create and deploys services ..."
for service in $services
do
    echo "$service ..."
    kubectl create -f ./srcs/$service-deployment.yaml 2>/dev/null 1>&2
    echo "$service done"
done
echo "Done ! :)"

echo "About to open the dashboard ..."
sudo minikube dashboard