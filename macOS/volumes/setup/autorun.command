#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

pushd scripts
for script in *.sh; do
    bash -l "./$script"
done

sudo rm -rf /tmp/*

sudo mdutil -E /
sudo log stream | grep -q -E 'mds.*Released.*BackgroundTask' || true
