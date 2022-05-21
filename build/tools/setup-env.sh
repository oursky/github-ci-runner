#!/usr/bin/bash
set -euxo pipefail

echo 'HELM_PLUGINS=/ci/tools/helm/plugins' | tee -a /etc/environment
