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
    "gnu-tar" \
    "jq" \
    "ruby" \
    "wget" \
    "zstd"

cat <<EOF | sudo tee -a ~/.profile
source /opt/homebrew/opt/asdf/libexec/asdf.sh
export PATH="/opt/homebrew/opt/ruby/bin:\$PATH"
export PATH="\$PATH:\$(gem env gemdir)/bin"
EOF
