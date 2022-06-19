#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

ls /Volumes/xcodes/*.app > /Volumes/xcodes/apps-new.list

cmp --silent /Volumes/xcodes/apps.list /Volumes/xcodes/apps-new.list || \
    jdupes -r -B /Volumes/xcodes >/dev/null

mv /Volumes/xcodes/apps-new.list /Volumes/xcodes/apps.list
