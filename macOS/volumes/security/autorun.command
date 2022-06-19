#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

pushd scripts
for script in *.sh; do
    bash -l "./$script"
done
