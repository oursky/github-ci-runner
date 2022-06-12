#!/bin/bash

set -euo pipefail

if [[ $EUID != 0 ]] ; then
    echo 'Need root.'
    exit 1
fi

cd "${0%/*}"
mount -u -w '/Volumes/Macintosh HD'
/usr/sbin/installer -pkg provisioner.pkg -target '/Volumes/Data'
shutdown -h now
