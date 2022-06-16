#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

mkdir -p /Volumes/xcodes/staging
pushd xips
for XIP in *.xip; do
    test -e "../apps/${XIP%\+*}.app" && continue
    ../../../bin/unxip "$XIP" "/Volumes/xcodes/staging"
    mv "/Volumes/xcodes/staging/Xcode.app" "/Volumes/xcodes/${XIP%\+*}.app"
done
popd
rmdir /Volumes/xcodes/staging
