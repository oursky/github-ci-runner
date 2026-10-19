#!/bin/bash

set -euxo pipefail

for PREFIX in "$@"; do
    VERSION="$(curl -sSf https://xcodereleases.com/data.json | jq -r --arg v "$PREFIX" \
        'first(.[] | select(.version.release.release == true) | .version.number | select(. == $v or startswith($v + "."))) // error("no Xcode release for \($v)")')"
    XIP="$BUILD_ROOT/xips/Xcode_$VERSION.xip"
    test -e "$XIP" && continue
    STAGING="$(mktemp -d)"
    xcodes download "$VERSION" --directory "$STAGING"
    mv "$STAGING"/*.xip "$XIP"
    rmdir "$STAGING"
done
