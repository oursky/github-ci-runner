#!/bin/bash
set -euxo pipefail

CERTIFICATES=(
    'AppleWWDRCAG3.cer'
    'DeveloperIDG2CA.cer'
)
# swiftc -o /tmp/add-certificate ../assets/add-certificate.swift
sudo security authorizationdb write com.apple.trust-settings.admin allow
for CERT in "${CERTIFICATES[@]}"; do
    curl -o "/tmp/$CERT" "https://www.apple.com/certificateauthority/$CERT"
    security add-trusted-cert -d -r unspecified -k login.keychain "/tmp/$CERT"
    rm "/tmp/$CERT"
done
