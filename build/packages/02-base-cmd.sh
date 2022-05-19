#!/usr/bin/bash
set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/ubuntu20/20220508.1/images/linux/toolsets/toolset-2204.json
apt-fast install --no-install-recommends \
    "acl" \
    "aria2" \
    "binutils" \
    "bison" \
    "brotli" \
    "bzip2" \
    "coreutils" \
    "curl" \
    "file" \
    "flex" \
    "ftp" \
    "haveged" \
    "jq" \
    "m4" \
    "mediainfo" \
    "netcat" \
    "net-tools" \
    "p7zip-full" \
    "parallel" \
    "pass" \
    "patchelf" \
    "pollinate" \
    "rsync" \
    "shellcheck" \
    "sphinxsearch" \
    "sqlite3" \
    "ssh" \
    "sshpass" \
    "subversion" \
    "sudo" \
    "swig" \
    "telnet" \
    "time" \
    "unzip" \
    "wget" \
    "zip"
