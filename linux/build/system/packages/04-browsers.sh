#!/usr/bin/bash
set -euxo pipefail

curl -sL "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -o "/tmp/chrome.deb"
apt-fast install "/tmp/chrome.deb" -f
echo 'export CHROME_BIN=/usr/bin/google-chrome' > /etc/profile.d/10-chrome.sh
rm -f /etc/cron.daily/google-chrome /etc/apt/sources.list.d/google-chrome.list /etc/apt/sources.list.d/google-chrome.list.save
