#!/bin/bash

set -xe

FULL=$2
IP=$1

if [[ -z $IP ]] ; then
  echo "please provide host ip"
  exit
fi

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

# NO USE? #
#microk8s enable ingress
#kubectl edit cm -n ingress  nginx-load-balancer-microk8s-conf
#
#data:
#  use-forwarded-headers: "true"
#
# After edit cm, restart ingress-nginx pod


#helm repo add traefik https://traefik.github.io/charts --force-update
# or https://helm.traefik.io/traefik
#helm pull traefik/traefik
#helm repo add argo https://argoproj.github.io/argo-helm --force-update
#helm pull argo/argo
#helm repo add jetstack https://charts.jetstack.io --force-update
#helm pull jetstack/cert-manager

# Step 1. install Argo CD server
if [[ $FULL == "yes" ]]; then
  kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
#  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
  kubectl apply -n argocd -f _workspace/argocd/install.yaml


# Step 2. install Argo CD client
# curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
  tar -zxvf  ./bin/argocdcli.tgz
  sudo install -m 555 ./argocd-linux-amd64 /usr/local/bin/argocd
  rm argocd-linux-amd64

# Step 3. install Traefik
  kubectl create namespace traefik --dry-run=client -o yaml | kubectl apply -f -
#  kubectl apply -n argocd -f _workspace/traefik/install.yaml
  helm install traefik ./_workspace/traefik/helm-crd -n traefik --set logs.general.level=DEBUG

# Step 4. install cert-manager
  kubectl create namespace cert-manager --dry-run=client -o yaml | kubectl apply -f -
  helm install cert-manager ./_workspace/cert-manager -n cert-manager
  sleep 10
fi

# expose argocd service to external traffic
#kubectl apply -f template/selfSignIssuer.yaml 
#kubectl apply -f template/argocd-ingress-nginx-cert-manager.yaml

kubectl port-forward -n argocd --address $IP  svc/argocd-server 8083:443 &
TRAEFIK=$(kubectl get pods -n traefik --selector "app.kubernetes.io/name=traefik" --output=name)
kubectl port-forward -n traefik --address $IP $TRAEFIK 9000:9000 &
kubectl port-forward -n traefik --address $IP $TRAEFIK 8000:8000 &
#sudo cp ./systemd/argocd-aio.service   /etc/systemd/system/ 


# Get the password
argocd admin initial-password -n argocd


# cli login
# argocd login argocd.example.com
# argocd account update-password



#Create An Application From A Git Repository
#argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
