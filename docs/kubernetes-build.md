# Build

```console
git clone https://github.com/kubernetes/kubernetes
cd kubernetes
# for MacOS Docker-machine
#export KUBERNETES_HTTP_PROXY=http://username:password@proxyaddr:proxyport
#export KUBERNETES_HTTPS_PROXY=https://username:password@proxyaddr:proxyport
go env -w GOBIN=
make quick-release
```

output  

```console
+++ [0412 06:42:43] Verifying Prerequisites....
+++ [0412 06:42:44] Building Docker image kube-build:build-4548da4dfb-5-v1.13.15-1
+++ [0412 06:44:02] Creating data container kube-build-data-4548da4dfb-5-v1.13.15-1
+++ [0412 06:44:15] Syncing sources to container
+++ [0412 06:44:18] Running build command...
+++ [0412 06:44:25] Building go targets for linux/amd64:
    ./vendor/k8s.io/code-generator/cmd/deepcopy-gen
+++ [0412 06:44:31] Building go targets for linux/amd64:
    ./vendor/k8s.io/code-generator/cmd/defaulter-gen
+++ [0412 06:44:36] Building go targets for linux/amd64:
    ./vendor/k8s.io/code-generator/cmd/conversion-gen
+++ [0412 06:44:43] Building go targets for linux/amd64:
    ./vendor/k8s.io/kube-openapi/cmd/openapi-gen
+++ [0412 06:44:51] Building go targets for linux/amd64:
    ./vendor/github.com/go-bindata/go-bindata/go-bindata
warning: ignoring symlink /go/src/k8s.io/kubernetes/_output/dockerized/go/src/k8s.io/kubernetes
go: warning: "k8s.io/kubernetes/vendor/github.com/go-bindata/go-bindata/..." matched no packages
+++ [0412 06:44:52] Building go targets for linux/amd64:
    cmd/kube-proxy
    cmd/kube-apiserver
    cmd/kube-controller-manager
    cmd/kubelet
    cmd/kubeadm
    cmd/kube-scheduler
    vendor/k8s.io/apiextensions-apiserver
    cluster/gce/gci/mounter
warning: ignoring symlink /go/src/k8s.io/kubernetes/_output/dockerized/go/src/k8s.io/kubernetes
go: warning: "k8s.io/kubernetes/vendor/github.com/go-bindata/go-bindata/..." matched no packages
+++ [0412 06:46:49] Building go targets for linux/amd64:
    cmd/kube-proxy
    cmd/kubeadm
    cmd/kubelet
warning: ignoring symlink /go/src/k8s.io/kubernetes/_output/dockerized/go/src/k8s.io/kubernetes
go: warning: "k8s.io/kubernetes/vendor/github.com/go-bindata/go-bindata/..." matched no packages
+++ [0412 06:47:05] Building go targets for linux/amd64:
    cmd/kubectl
warning: ignoring symlink /go/src/k8s.io/kubernetes/_output/dockerized/go/src/k8s.io/kubernetes
go: warning: "k8s.io/kubernetes/vendor/github.com/go-bindata/go-bindata/..." matched no packages
+++ [0412 06:47:17] Building go targets for linux/amd64:
    cmd/gendocs
    cmd/genkubedocs
    cmd/genman
    cmd/genyaml
    cmd/genswaggertypedocs
    cmd/linkcheck
    vendor/github.com/onsi/ginkgo/ginkgo
    test/e2e/e2e.test
    cluster/images/conformance/go-runner
warning: ignoring symlink /go/src/k8s.io/kubernetes/_output/dockerized/go/src/k8s.io/kubernetes
go: warning: "k8s.io/kubernetes/vendor/github.com/go-bindata/go-bindata/..." matched no packages
+++ [0412 06:48:26] Building go targets for linux/amd64:
    cmd/kubemark
    vendor/github.com/onsi/ginkgo/ginkgo
    test/e2e_node/e2e_node.test
+++ [0412 06:48:56] Syncing out of container
+++ [0412 06:49:11] Starting tarball: client linux-amd64
+++ [0412 06:49:11] Building tarball: manifests
+++ [0412 06:49:11] Building tarball: src
+++ [0412 06:49:11] Waiting on tarballs
tar: Removing leading `/' from member names
tar: Removing leading `/' from member names
tar: Removing leading `/' from member names
tar: Removing leading `/' from member names
tar: Removing leading `/' from member names
+++ [0412 06:49:15] Building tarball: node linux-amd64
+++ [0412 06:49:15] Building images: linux-amd64
+++ [0412 06:49:15] Starting docker build for image: kube-apiserver-amd64
+++ [0412 06:49:15] Starting docker build for image: kube-controller-manager-amd64
+++ [0412 06:49:15] Starting docker build for image: kube-scheduler-amd64
+++ [0412 06:49:15] Starting docker build for image: kube-proxy-amd64
+++ [0412 06:49:15] Building conformance image for arch: amd64
+++ [0412 06:49:15] Building hyperkube image for arch: amd64
DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

+++ [0412 06:49:42] Deleting docker image k8s.gcr.io/kube-scheduler-amd64:v1.18.21-rc.0.1_0f3e6609388def-dirty
+++ [0412 06:49:42] Deleting docker image k8s.gcr.io/kube-proxy-amd64:v1.18.21-rc.0.1_0f3e6609388def-dirty
+++ [0412 06:49:42] Deleting docker image k8s.gcr.io/kube-controller-manager-amd64:v1.18.21-rc.0.1_0f3e6609388def-dirty
+++ [0412 06:49:42] Deleting docker image k8s.gcr.io/kube-apiserver-amd64:v1.18.21-rc.0.1_0f3e6609388def-dirty
+++ [0412 06:50:00] Deleting conformance image k8s.gcr.io/conformance-amd64:v1.18.21-rc.0.1_0f3e6609388def-dirty
+++ [0412 06:50:24] Deleting hyperkube image k8s.gcr.io/hyperkube-amd64:v1.18.21-rc.0.1_0f3e6609388def-dirty
+++ [0412 06:50:24] Docker builds done
+++ [0412 06:50:24] Building tarball: server linux-amd64
+++ [0412 06:51:08] Building tarball: final
+++ [0412 06:51:08] Starting tarball: test linux-amd64
+++ [0412 06:51:08] Waiting on test tarballs
+++ [0412 06:51:37] Building tarball: test portable


```

