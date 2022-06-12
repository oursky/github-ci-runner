#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

sudo rm /Library/LaunchDaemons/com.oursky.provisioner.plist
sudo rm /Library/LaunchAgents/com.oursky.provisioner.plist

while :; do
    osascript -e 'tell application "System Events" to shut down'
    sleep 1
done
