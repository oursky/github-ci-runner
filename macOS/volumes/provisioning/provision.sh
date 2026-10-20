#!/bin/bash

set -euo pipefail

if [[ $EUID != 0 ]] ; then
    echo 'Need root.'
    exit 1
fi

cd "${0%/*}"
mount -u -w '/Volumes/Macintosh HD'

cp -r ./payload/ /Volumes/Data/
mkdir -p /Volumes/Data/private/var/db
touch /Volumes/Data/private/var/db/.AppleSetupDone
./scripts/setup-tcc.sh
shutdown -h now
