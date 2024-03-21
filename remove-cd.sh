#!/bin/bash

FULL=$1

sudo kill -9  $(ps -aux | grep 8083 | awk '{print $2}' | head -n 1)

if [[ $FULL == "yes" ]]; then
  kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
  kubectl delete ns argocd
  rm -rf /usr/local/bin/argocd
fi

