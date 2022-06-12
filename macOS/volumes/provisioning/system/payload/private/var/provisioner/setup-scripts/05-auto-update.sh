#!/bin/bash

set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/macOS-12/20220605.1/images/macos/provision/configuration/disable-auto-updates.sh

# Disabling automatic updates
softwareupdate --schedule off
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 0
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 0
defaults write com.apple.commerce AutoUpdate -bool false
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false
