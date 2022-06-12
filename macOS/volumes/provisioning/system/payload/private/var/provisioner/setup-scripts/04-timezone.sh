#!/bin/bash

set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/macOS-12/20220605.1/images/macos/provision/configuration/ntpconf.sh

# Set the timezone to UTC.
echo The Timezone setting to UTC...
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
