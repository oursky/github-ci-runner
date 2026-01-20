#!/bin/bash
set -euxo pipefail

PLATFORMS=(
    'iOS'
    'watchOS'
)

for APP in /Volumes/xcodes/*.app; do
    sudo DEVELOPER_DIR="$APP" xcrun xcodebuild -license accept
    sudo DEVELOPER_DIR="$APP" xcrun xcodebuild -runFirstLaunch
    # Trigger app verification
    DEVELOPER_DIR="$APP" xcrun simctl list
    for PLATFORM in "${PLATFORMS[@]}"; do
        DEVELOPER_DIR="$APP" xcodebuild -downloadPlatform $PLATFORM
    done
done

CERTIFICATES=(
    'AppleWWDRCAG3.cer'
    'DeveloperIDG2CA.cer'
)

for CERT in "${CERTIFICATES[@]}"; do
    curl -o "/tmp/$CERT" "https://www.apple.com/certificateauthority/$CERT"
    sudo "/Volumes/setup/bin/add-certificate" "/tmp/$CERT"
    rm "/tmp/$CERT"
done
