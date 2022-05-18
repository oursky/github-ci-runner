#!/usr/bin/bash
set -euxo pipefail

./setup-env.sh
./setup-dpkg.sh

for s in packages/*.sh; do
    "$s"
done

./setup-runner.sh
./cleanup.sh
