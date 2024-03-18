#!/bin/bash

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
#sudo snap install microk8s --classic --channel=1.23/stable
#sudo usermod -a -G microk8s eddie
#sudo chown -R eddie ~/.kube


# Add proxy at 
# /var/snap/microk8s/current/args/containerd-env
# restart microk8s again

#
#ctr -a /var/snap/microk8s/common/run/containerd.sock -n k8s.io i pull --user "chantyu:Usa1196597" docker.io/calico/cni:v3.19.1
#docker.io/calico/cni:v3.19.1
#docker.io/calico/pod2daemon-flexvol:v3.19.1
#docker.io/calico/node:v3.19.1
#docker.io/calico/kube-controllers:v3.17.3


#microk8s kubectl get  no
#NAME       STATUS   ROLES    AGE   VERSION
#chantjmp   Ready    <none>   29m   v1.23.17-2+40cc20cc310518

#
