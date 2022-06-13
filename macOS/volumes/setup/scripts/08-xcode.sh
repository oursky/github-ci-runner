#!/bin/bash
set -euxo pipefail

for APP in /Volumes/xcodes/*.app; do
    sudo xcode-select -s "$APP"
    sudo xcodebuild -license accept
    sudo xcodebuild -runFirstLaunch
done
sudo xcode-select -r

CERTIFICATES=(
    'AppleWWDRCAG3.cer'
    'DeveloperIDG2CA.cer'
)
for CERT in "${CERTIFICATES[@]}"; do
    curl -o "/tmp/$CERT" "https://www.apple.com/certificateauthority/$CERT"
    sudo swift ../assets/add-certificate.swift "/tmp/$CERT"
    rm "/tmp/$CERT"
done
