#!/usr/bin/bash
set -euxo pipefail

RUNNER_VERSION=2.292.0
mkdir /ci/runner

curl -L "https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz" | \
    tar xzC /ci/runner
