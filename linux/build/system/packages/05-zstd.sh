#!/usr/bin/bash
set -euxo pipefail

git clone https://github.com/facebook/zstd -b v1.5.2 /tmp/zstd
sudo make -C /tmp/zstd -j install
