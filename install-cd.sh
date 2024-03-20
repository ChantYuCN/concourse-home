#!/bin/bash

set -xe

# install dependence
#sudo apt install snap -y
#
#if [[ $http_proxy ]]; then
#  sudo snap set system proxy.http=$http_proxy
#fi
#
#if [[ $https_proxy ]]; then
#  sudo snap set system proxy.https=$https_proxy
#fi
#
#sudo snap install microk8s --classic --channel=1.28/stable
#sudo usermod -a -G microk8s eddie
#sudo chown -R eddie ~/.kube


# Add proxy at 
# /var/snap/microk8s/current/args/containerd-env
# restart microk8s again

# if pull upto limit, plz pull the image by your seld
#ctr -a /var/snap/microk8s/common/run/containerd.sock -n k8s.io i pull --user "[dockerhub username]:[passowrd]" [image]
#docker.io/calico/cni:v3.25.1
#docker.io/calico/node:v3.25.1
#docker.io/calico/pod2daemon-flexvol:v3.19.1
#docker.io/calico/kube-controllers:v3.25.1
#coredns/coredns:1.10.1

#microk8s kubectl get  no
#NAME       STATUS   ROLES    AGE   VERSION
#chantjmp   Ready    <none>   29m   v1.23.17-2+40cc20cc310518

#mkdir -p ~/.kube
#microk8s config >> ~/.kube/config 
#chmod 600 ~/.kube/config
#chown 1000:1000 ~/.kube/config

# after 1.28, coredns is deployed
# microk8s enable dns:10.248.2.1
# microk8s enable cert-manager
# restart microk8s again

#microk8s enable ingress
#kubectl edit cm -n ingress  nginx-load-balancer-microk8s-conf
#
#data:
#  use-forwarded-headers: "true"
#
# After edit cm, restart ingress-nginx pod


# Step 1. install Argo CD server
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Step 2. install Argo CD client
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64


