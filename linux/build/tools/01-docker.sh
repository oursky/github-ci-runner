#!/usr/bin/bash
set -euxo pipefail

COMPOSE_SWITCH_VERSION="v1.0.4"
COMPOSE_SWITCH_URL="https://github.com/docker/compose-switch/releases/download/${COMPOSE_SWITCH_VERSION}/docker-compose-linux-$(dpkg --print-architecture)"
curl -L "$COMPOSE_SWITCH_URL" -o /ci/tools/bin/docker-compose
chmod +x /ci/tools/bin/docker-compose

KUBECTL_VERSION=$(curl -L -s "https://dl.k8s.io/release/stable.txt")
curl -o /ci/tools/bin/kubectl -L "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"
chmod +x /ci/tools/bin/kubectl

curl -sL "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash -s - 4.5.5 /ci/tools/bin

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | HELM_INSTALL_DIR=/ci/tools/bin bash

export HELM_PLUGINS=/ci/tools/helm/plugins
echo "export HELM_PLUGINS=$HELM_PLUGINS" | sudo tee /etc/profile.d/20-helm.sh

helm plugin install https://github.com/databus23/helm-diff

curl -o /ci/tools/bin/helmfile -L "https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_amd64"
chmod +x /ci/tools/bin/helmfile

curl -o /ci/tools/bin/docuum -L "https://github.com/stepchowfun/docuum/releases/download/v0.21.1/docuum-x86_64-unknown-linux-gnu"
chmod +x /ci/tools/bin/docuum
