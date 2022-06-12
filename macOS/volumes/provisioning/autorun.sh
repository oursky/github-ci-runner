#!/bin/bash

set -euox pipefail

sleep 5
osascript -e 'tell application "System Events" to shut down'
