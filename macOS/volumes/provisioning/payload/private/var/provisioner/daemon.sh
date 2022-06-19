#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

export USERNAME=runner
export USERPASS=runner

pushd daemon-scripts
for script in *.sh; do
    "./$script"
done
