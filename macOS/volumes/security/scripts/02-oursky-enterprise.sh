#!/bin/bash
set -euxo pipefail

security import ../assets/Certificates.p12 -t agg -k login.keychain -P '' -T /usr/bin/codesign
security set-key-partition-list -S apple-tool:,apple: -s -k runner login.keychain
security find-identity -v -p codesigning

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
