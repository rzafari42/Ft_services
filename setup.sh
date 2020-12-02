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
kubectl apply -f ./srcs/metallb/metallb-config.yaml

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
echo "LoadBalancer IP : ${IP}"

echo "Let's build every docker images ..."
docker build -t nginx srcs/nginx
docker build -t nginx srcs/PhpMyAdmin
docker build -t nginx srcs/wordpress
docker build -t nginx srcs/MySQL
docker build -t nginx srcs/ftps
docker build -t nginx srcs/Grafana
docker build -t nginx srcs/InfluxDB





