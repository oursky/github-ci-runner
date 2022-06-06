#!/usr/bin/bash
set -euxo pipefail

echo 'DEBIAN_FRONTEND=noninteractive' | tee -a /etc/environment
echo 'ImageOS=ubuntu22' | tee -a /etc/environment
echo 'XDG_CONFIG_HOME=/home/runner/.config' | tee -a /etc/environment
