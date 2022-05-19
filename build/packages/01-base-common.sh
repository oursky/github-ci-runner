#!/usr/bin/bash
set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/ubuntu20/20220508.1/images/linux/toolsets/toolset-2204.json
apt-fast install --no-install-recommends \
    "autoconf" \
    "automake" \
    "build-essential" \
    "dbus" \
    "dnsutils" \
    "dpkg" \
    "fakeroot" \
    "fonts-noto-color-emoji" \
    "gnupg2" \
    "imagemagick" \
    "iproute2" \
    "iputils-ping" \
    "locales" \
    "mercurial" \
    "openssh-client" \
    "p7zip-rar" \
    "pkg-config" \
    "python-is-python3" \
    "rpm" \
    "texinfo" \
    "tk" \
    "tzdata" \
    "upx" \
    "xorriso" \
    "xvfb" \
    "xz-utils" \
    "zsync"
