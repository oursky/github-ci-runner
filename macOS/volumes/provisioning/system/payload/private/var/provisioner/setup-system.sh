#!/bin/bash

set -euxo pipefail

touch '/private/var/db/.AppleSetupDone'

utils/set-auto-login.sh "$USER_NAME" "$USER_PASS"
echo '%admin ALL=(ALL) NOPASSWD: ALL' > /private/etc/sudoers.d/admin

sysadminctl -addUser "$USER_NAME" -admin -password "$USER_PASS"
