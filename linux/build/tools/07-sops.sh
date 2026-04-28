#!/usr/bin/bash
set -euxo pipefail
mkdir -p /var/runner/tools/sops

curl -fsSL \
    "https://github.com/getsops/sops/releases/download/v3.12.2/sops-v3.12.2.linux.amd64" \
    -o /var/runner/tools/sops/sops
chmod +x /var/runner/tools/sops/sops

cat <<EOF | sudo tee /etc/profile.d/20-sops.sh
export PATH="\$PATH:/var/runner/tools/sops"
EOF
