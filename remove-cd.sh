#!/bin/bash

set -xe

FULL=$1

sudo kill -9  $(ps -aux | grep " 8083:443" | awk '{print $2}' | head -n 1)
sudo kill -9  $(ps -aux | grep " 9000:9000" | awk '{print $2}' | head -n 1)
sudo kill -9  $(ps -aux | grep " 8000:8000" | awk '{print $2}' | head -n 1)


if [[ $FULL == "yes" ]]; then
  kubectl delete -n argocd -f _workspace/argocd/install.yaml
  kubectl delete ns argocd
  sudo rm -rf /usr/local/bin/argocd
  helm delete -n traefik traefik
  kubectl delete ns traefik
fi

