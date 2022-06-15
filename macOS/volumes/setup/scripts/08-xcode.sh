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
swiftc -o /tmp/add-certificate ../assets/add-certificate.swift
for CERT in "${CERTIFICATES[@]}"; do
    curl -o "/tmp/$CERT" "https://www.apple.com/certificateauthority/$CERT"
    /tmp/add-certificate "/tmp/$CERT"
    rm "/tmp/$CERT"
done
rm /tmp/add-certificate
