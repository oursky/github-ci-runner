#!/usr/bin/bash
set -euxo pipefail

echo 'HELM_PLUGINS=/ci/tools/helm/plugins' | tee -a /etc/environment
echo "ANDROID_HOME=/ci/tools/android" | tee -a /etc/environment
sed 's/:\/usr\/bin:/:\/usr\/bin:\/ci\/bin:/' -i /etc/environment
