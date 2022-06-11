#!/usr/bin/bash
set -euxo pipefail

mkdir -p /ci/tools
git clone https://github.com/asdf-vm/asdf.git /ci/tools/asdf --branch v0.10.0

cat <<EOF | sudo tee /etc/profile.d/20-asdf.sh
export ASDF_DIR=/ci/tools/asdf
export ASDF_DATA_DIR=/ci/tools/asdf
export PATH="\$PATH:/ci/tools/asdf/bin:/ci/tools/asdf/shims"
EOF
