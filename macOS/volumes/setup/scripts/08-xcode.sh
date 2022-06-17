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
swiftc -o /tmp/add-certificate ../assets/add-certificate.swift
for CERT in "${CERTIFICATES[@]}"; do
    curl -o "/tmp/$CERT" "https://www.apple.com/certificateauthority/$CERT"
    /tmp/add-certificate "/tmp/$CERT"
    rm "/tmp/$CERT"
done
rm /tmp/add-certificate

cp ../assets/oursky.keychain ~/Library/Keychains
source ../assets/.env
security list-keychains -s `security list-keychains | xargs` ~/Library/Keychains/oursky.keychain
security unlock-keychain -p $KEYCHAIN_PASSWORD ~/Library/Keychains/oursky.keychain
security set-key-partition-list -S apple-tool:,apple: -s -k $KEYCHAIN_PASSWORD ~/Library/Keychains/oursky.keychain
security find-identity -v -p codesigning

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
rm -f ../assets/.env