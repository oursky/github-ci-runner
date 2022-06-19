#!/bin/bash
set -euxo pipefail

sudo softwareupdate --install-rosetta --agree-to-license

sudo mkdir -p /usr/local/bin
