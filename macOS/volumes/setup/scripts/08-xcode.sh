#!/bin/bash
set -euxo pipefail

for APP in /Volumes/xcodes/*.app; do
    sudo DEVELOPER_DIR="$APP" xcrun xcodebuild -license accept
    sudo DEVELOPER_DIR="$APP" xcrun xcodebuild -runFirstLaunch
    # Trigger app verification
    DEVELOPER_DIR="$APP" xcrun simctl list
done
