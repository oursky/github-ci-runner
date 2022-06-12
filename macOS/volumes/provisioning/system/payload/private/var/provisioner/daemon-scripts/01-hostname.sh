#!/bin/bash

set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/macOS-12/20220605.1/images/macos/provision/configuration/configure-hostname.sh

name="runner-$(openssl rand -base64 3 | tr '[:upper:]' '[:lower:]')"
scutil --set HostName "${name}.local"
scutil --set LocalHostName $name
scutil --set ComputerName "${name}.local"
