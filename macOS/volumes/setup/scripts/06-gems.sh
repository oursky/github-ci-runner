#!/bin/bash
set -euxo pipefail

sudo gem install \
    cocoapods \
    bundler

mkdir -p /Volumes/cache/CocoaPods
ln -s /Volumes/cache/CocoaPods ~/Library/Caches/CocoaPods
