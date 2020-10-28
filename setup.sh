#!/usr/bin/env zsh



#kubectl delete --all deployment
#kubectl delete --all svc
#kubectl delete --all pods
#kubectl delete --all statefulset
#kubectl delete --all pvc
#kubectl delete --all pv
kubectl delete --all secret


if ! which conntrack &>/dev/null; then # si y a pas le binaire de conntrack
	sudo apt-get install -y conntrack
fi

if ! kubectl version &> /dev/null; then
        service nginx stop
        sudo minikube start --driver=none
        echo "MIinikube ..."
fi


sudo chown -R user42 $HOME/.kube $HOME/.minikube
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config

# see what changes would be made, returns nonzero returncode if different
echo "1111111111111111111"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
echo "2222222222222222222"
# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system



# see what changes would be made, returns nonzero returncode if different
echo "33333333333333333333"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

# actually apply the changes, returns nonzero returncode on errors only
echo "44444444444444444444"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system


#Install MetalLB
echo "MetlLB installation"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"


#echo "About to build image ..."
#docker build -t nginx nginx
#echo "Image build with success"
