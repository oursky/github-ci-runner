#!/usr/bin/bash
set -euxo pipefail

KUBE_AGENT_VERSION=sha-48b89a1309
RUNNER_VERSION=2.294.0

curl -L https://github.com/oras-project/oras/releases/download/v0.12.0/oras_0.12.0_linux_amd64.tar.gz | \
    tar -xzC /tmp oras
/tmp/oras pull -o /ci "ghcr.io/oursky/github-actions-manager/kube-agent:$KUBE_AGENT_VERSION"
chmod +x /ci/kube-agent

mkdir /ci/runner
curl -L "https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz" | \
    tar xzC /ci/runner
