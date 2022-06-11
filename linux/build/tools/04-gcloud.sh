#!/usr/bin/bash
set -euxo pipefail

sudo apt-get install -y python-is-python3

mkdir -p /ci/tools
curl -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-386.0.0-linux-x86_64.tar.gz | \
    tar xzC /ci/tools
/ci/tools/google-cloud-sdk/bin/gcloud components install gke-gcloud-auth-plugin

pushd /ci/tools/google-cloud-sdk/bin
for bin in *; do
    test -f "$bin" && test -x "$bin" && \
        ln -s "/ci/tools/google-cloud-sdk/bin/$bin" "/ci/bin/$bin"
done
popd
