#!/bin/bash

set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/macOS-12/20220605.1/images/macos/provision/configuration/configure-machine.sh

# Turn off hibernation and get rid of the sleepimage
pmset hibernatemode 0
rm -f /var/vm/sleepimage

# Disable App Nap System Wide
defaults write NSGlobalDomain NSAppSleepDisabled -bool YES
