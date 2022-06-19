#!/bin/bash
set -euxo pipefail

for APP in /Volumes/xcodes/*.app; do
    sudo DEVELOPER_DIR="$APP" xcrun xcodebuild -license accept
    sudo DEVELOPER_DIR="$APP" xcrun xcodebuild -runFirstLaunch
    # Trigger app verification
    DEVELOPER_DIR="$APP" xcrun simctl list
done

CERTIFICATES=(
    'AppleWWDRCAG3.cer'
    'DeveloperIDG2CA.cer'
)
sudo security authorizationdb write com.apple.trust-settings.admin allow
for CERT in "${CERTIFICATES[@]}"; do
    curl -o "/tmp/$CERT" "https://www.apple.com/certificateauthority/$CERT"
    security add-trusted-cert -d -r unspecified -k login.keychain "/tmp/$CERT"
    rm "/tmp/$CERT"
done
