#!/bin/bash

cd "${0%/*}"

if test -e /dev/tty.virtio; then
   exec <>/dev/tty.virtio >&0 2>&0
fi
./runner.sh

sudo shutdown -h now
