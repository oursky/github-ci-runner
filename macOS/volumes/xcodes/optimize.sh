#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

jdupes -r -B /Volumes/xcodes >/dev/null

for APP in /Volumes/xcodes/*.app; do
    spctl -a -vv "$APP"
done
