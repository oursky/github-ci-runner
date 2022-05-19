#!/usr/bin/bash
set -euxo pipefail

apt-fast install moby-cli moby-buildx moby-compose
docker buildx install

COMPOSE_SWITCH_VERSION="v1.0.4"
COMPOSE_SWITCH_URL="https://github.com/docker/compose-switch/releases/download/${COMPOSE_SWITCH_VERSION}/docker-compose-linux-$(dpkg --print-architecture)"
curl -L "$COMPOSE_SWITCH_URL" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

KUBECTL_VERSION=$(curl -L -s "https://dl.k8s.io/release/stable.txt")
curl -o /usr/local/bin/kubectl -L "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"
chmod +x /usr/local/bin/kubectl

curl -sL "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
mv kustomize /usr/local/bin

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

curl -o /usr/local/bin/helmfile -L "https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_amd64"
chmod +x /usr/local/bin/helmfile

helm plugin install https://github.com/databus23/helm-diff
