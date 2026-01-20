#!/bin/bash
set -euxo pipefail

export HOMEBREW_INSTALL_FROM_API=1

mkdir -p /Volumes/cache/Homebrew
ln -s /Volumes/cache/Homebrew ~/Library/Caches/Homebrew

HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
curl -L "${HOMEBREW_INSTALL_URL}" | NONINTERACTIVE=1 /bin/bash

/opt/homebrew/bin/brew analytics off

cat <<EOF | sudo tee -a ~/.profile
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=3650
export HOMEBREW_CASK_OPTS="--no-quarantine"
eval "\$(/opt/homebrew/bin/brew shellenv)"
EOF
