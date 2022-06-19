#!/bin/bash

set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/macOS-12/20220605.1/images/macos/provision/configuration/configure-hostname.sh

name="mac-runner-$(openssl rand -hex 3)"
scutil --set HostName "${name}.local"
scutil --set LocalHostName $name
scutil --set ComputerName "${name}.local"
