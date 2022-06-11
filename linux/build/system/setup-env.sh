#!/usr/bin/bash
set -euxo pipefail

apt-fast install sudo
echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers
adduser --disabled-password --gecos "" --uid 1000 runner
usermod -aG sudo runner
usermod -aG sudo root
