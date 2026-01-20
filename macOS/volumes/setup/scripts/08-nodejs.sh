#!/bin/bash
set -euxo pipefail

curl -L https://raw.githubusercontent.com/tj/n/master/bin/n | sudo bash -s - 16.15.1
sudo corepack enable
sudo -u runner corepack prepare yarn@1.22.19 --activate
sudo -u runner corepack prepare pnpm@7.2.1 --activate

mkdir -p ~/Library/pnpm

cat <<EOF | sudo tee -a ~/.profile
export PNPM_HOME=~/Library/pnpm
export PATH="\$PATH:\$PNPM_HOME:~/.yarn/bin"
EOF
