#!/usr/bin/bash
set -euxo pipefail

rm -rf /var/lib/apt/lists/*

# https://github.com/actions/virtual-environments/blob/ubuntu20/20220508.1/images/linux/scripts/installers/cleanup.sh

apt-get clean
rm -rf /tmp/*
rm -rf /root/.cache

find /var/log -type f -regex ".*\.gz$" -delete
find /var/log -type f -regex ".*\.[0-9]$" -delete
find /var/log/ -type f -exec cp /dev/null {} \;
