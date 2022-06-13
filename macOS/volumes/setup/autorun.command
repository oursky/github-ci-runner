#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

sudo networksetup -setMTU Ethernet 1420

pushd scripts
for script in *.sh; do
    bash -l "./$script"
done
