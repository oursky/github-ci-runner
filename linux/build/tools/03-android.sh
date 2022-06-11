#!/usr/bin/bash
set -euxo pipefail

mkdir -p /ci/tools/android
export ANDROID_HOME=/ci/tools/android

mkdir -p "$ANDROID_HOME/cmdline-tools"
curl -L https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -o /tmp/commandlinetools.zip
unzip -d "$ANDROID_HOME/cmdline-tools" /tmp/commandlinetools.zip
rm /tmp/commandlinetools.zip

mv "$ANDROID_HOME/cmdline-tools/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"

cat <<EOF | sudo tee /etc/profile.d/20-android.sh
export ANDROID_HOME=$ANDROID_HOME
export PATH="\$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
EOF
