#!/usr/bin/bash
set -euxo pipefail

curl -L https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s - 16.15.1
corepack enable
sudo -u runner corepack prepare yarn@1.22.19 --activate
sudo -u runner corepack prepare pnpm@7.2.1 --activate

export PNPM_HOME=/var/runner/tools/pnpm/bin
cat <<EOF >> /etc/profile.d/10-nodejs.sh
export PNPM_HOME=$PNPM_HOME
export PATH="\$PATH:$PNPM_HOME"
EOF
