#!/usr/bin/bash
set -euxo pipefail

apt-fast install --no-install-recommends python3 python3-dev python3-pip python3-venv

export PATH="$PATH:/home/runner/.local/bin"
sudo -u runner python3 -m pip install pipx
sudo -u runner pipx install poetry==2.0.1

cat <<EOF >> /etc/profile.d/10-python.sh
export PATH="\$PATH:/home/runner/.local/bin"
EOF
