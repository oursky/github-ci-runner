#!/bin/bash
set -euxo pipefail

cd /tmp
git clone https://github.com/StackExchange/blackbox
sudo make -C blackbox copy-install
rm -rf blackbox
