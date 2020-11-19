#!/usr/bin/env zsh



#kubectl delete --all deployment
#kubectl delete --all svc
#kubectl delete --all pods
#kubectl delete --all statefulset
#kubectl delete --all pvc
#kubectl delete --all pv
kubectl delete --all secret


if ! which contrack &>/dev/null; then # si y a pas le binaire de conntrack
	sudo apt-get install -y conntrack
fi


if ! kubectl version 2>/dev/null 1>&2 ; then
        service nginx stop       
        sudo minikube start --driver=none  
        sudo chown -R user42 $HOME/.kube $HOME/.minikube
fi

export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config

#################################################
####            METALLB                      ####
#################################################

# see what changes would be made, returns nonzero returncode if different
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

#Install MetalLB by Manifest
echo "MetlLB installation ..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb/metallb-config.yaml

#echo "About to build image ..."
#docker build -t nginx nginx
#echo "Image build with success"
