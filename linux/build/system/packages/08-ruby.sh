#!/usr/bin/bash
set -euxo pipefail

apt-fast install --no-install-recommends ruby-full
gem install bundler
