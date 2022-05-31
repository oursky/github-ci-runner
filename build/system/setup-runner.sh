#!/usr/bin/bash
set -euxo pipefail

RUNNER_VERSION=2.291.1

apt-fast install dumb-init

# Manual install dependencies
# ref: https://github.com/actions/runner/pull/1585
apt-fast install liblttng-ust1 libkrb5-3 zlib1g libicu-dev libicu70 libyaml-dev

adduser --disabled-password --gecos "" --uid 1000 runner
usermod -aG sudo runner
usermod -aG sudo root
echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers

mkdir /opt/hostedtoolcache
chown runner:runner /opt/hostedtoolcache
chmod g+rwx /opt/hostedtoolcache
echo "AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache" | tee -a /etc/environment
