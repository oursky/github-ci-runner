#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

export USER_NAME=runner
export USER_PASS=runner

./setup-system.sh
./setup-user.sh
./setup-ssh.sh
