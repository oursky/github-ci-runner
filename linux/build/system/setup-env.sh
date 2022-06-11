#!/usr/bin/bash
set -euxo pipefail

cat <<EOF >> /etc/profile.d/01-ci-bin.sh
export DEBIAN_FRONTEND=noninteractive
export ImageOS=ubuntu22
export PATH="\$PATH:/ci/tools/bin"
EOF
