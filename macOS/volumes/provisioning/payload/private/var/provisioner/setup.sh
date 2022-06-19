#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

export USERNAME=runner
export USERPASS=runner

pushd setup-scripts
for script in *.sh; do
    "./$script"
done

sudo rm /Library/LaunchDaemons/com.oursky.provisioner.setup.plist
