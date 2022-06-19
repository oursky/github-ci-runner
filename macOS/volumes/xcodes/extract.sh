#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

mkdir -p /Volumes/xcodes/staging
for XIP in "$BUILD_ROOT"/xips/*.xip; do
    NAME="$(basename ${XIP%\+*})"
    test -e "/Volumes/xcodes/$NAME.app" && continue
    ../../bin/unxip "$XIP" "/Volumes/xcodes/staging"
    mv "/Volumes/xcodes/staging/Xcode.app" "/Volumes/xcodes/$NAME.app"
done
rmdir /Volumes/xcodes/staging
