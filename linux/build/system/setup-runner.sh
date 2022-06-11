#!/usr/bin/bash
set -euxo pipefail

apt-fast install dumb-init

# Manual install dependencies
# ref: https://github.com/actions/runner/pull/1585
apt-fast install liblttng-ust1 libkrb5-3 zlib1g libicu-dev libicu70 libyaml-dev

mkdir /opt/hostedtoolcache
chown runner:runner /opt/hostedtoolcache
chmod g+rwx /opt/hostedtoolcache

cat <<EOF >> /etc/profile.d/01-runner.sh
export AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
export ImageOS=ubuntu22
export PATH="\$PATH:/ci/tools/bin"
EOF
