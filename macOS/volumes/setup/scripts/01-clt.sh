#!/bin/bash
set -euxo pipefail

sudo installer -package ../assets/CommandLineTools_*.pkg -target /

sudo softwareupdate --install-rosetta --agree-to-license

sudo mkdir -p /usr/local/bin
