#!/bin/bash

cd "${0%/*}"
set -euxo pipefail

pushd scripts
for script in *.sh; do
    bash -l "./$script"
done

(
  sleep 1
  osascript -e 'tell application "Terminal" to close first window'
  osascript -e 'tell application "System Events" to shut down'
) &
