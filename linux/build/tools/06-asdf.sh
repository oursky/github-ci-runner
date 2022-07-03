#!/usr/bin/bash
set -euxo pipefail

mkdir -p /var/runner/tools
git clone https://github.com/asdf-vm/asdf.git /var/runner/tools/asdf --branch v0.10.0

cat <<EOF | sudo tee /etc/profile.d/20-asdf.sh
export ASDF_DIR=/var/runner/tools/asdf
export ASDF_DATA_DIR=/var/runner/tools/asdf
export PATH="\$PATH:/var/runner/tools/asdf/bin:/var/runner/tools/asdf/shims"
EOF
