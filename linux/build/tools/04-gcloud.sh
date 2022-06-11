#!/usr/bin/bash
set -euxo pipefail

sudo apt-get install -y python-is-python3

mkdir -p /ci/tools
curl -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-386.0.0-linux-x86_64.tar.gz | \
    tar xzC /ci/tools
/ci/tools/google-cloud-sdk/bin/gcloud components install gke-gcloud-auth-plugin

cat <<EOF | sudo tee /etc/profile.d/20-gcloud.sh
export PATH="\$PATH:/ci/tools/google-cloud-sdk/bin"
EOF
