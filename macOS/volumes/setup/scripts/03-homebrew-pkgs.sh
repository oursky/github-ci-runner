#!/bin/bash
set -euxo pipefail

brew install \
    "aria2" \
    "asdf" \
    "carthage" \
    "cmake" \
    "git" \
    "git-lfs" \
    "gnupg" \
    "jq" \
    "wget" \
    "zstd"

cat <<EOF | sudo tee -a ~/.profile
source /opt/homebrew/opt/asdf/libexec/asdf.sh
EOF
