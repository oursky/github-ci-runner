#!/usr/bin/bash
set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/ubuntu20/20220508.1/images/linux/toolsets/toolset-2204.json
apt-fast install --no-install-recommends \
    "lib32z1" \
    "libc++abi-dev" \
    "libc++-dev" \
    "libcurl4" \
    "libgbm-dev" \
    "libgconf-2-4" \
    "libgsl-dev" \
    "libgtk-3-0" \
    "libmagic-dev" \
    "libmagickcore-dev" \
    "libmagickwand-dev" \
    "libsecret-1-dev" \
    "libsqlite3-dev" \
    "libtool" \
    "libunwind8" \
    "libxkbfile-dev" \
    "libxss1" \
    "libssl-dev"
