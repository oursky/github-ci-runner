#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

jdupes -r -B /Volumes/xcodes -q 2>/dev/null
