#!/usr/bin/bash
set -euxo pipefail

KUBE_AGENT_VERSION=git-f946ad29d3
RUNNER_VERSION=2.294.0

curl -L https://github.com/oras-project/oras/releases/download/v0.13.0/oras_0.13.0_linux_amd64.tar.gz | \
    tar -xzC /tmp oras
/tmp/oras pull -o /var/runner "ghcr.io/oursky/github-actions-manager/kube-agent:$KUBE_AGENT_VERSION"
chmod +x /var/runner/kube-agent

sudo mkdir /runner
sudo chown runner:runner /runner
curl -L "https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz" | \
    tar xzC /runner
