#!/bin/bash

set -euxo pipefail

touch '/private/var/db/.AppleSetupDone'

../utils/set-auto-login.sh "$USERNAME" "$USERPASS"
echo '%admin ALL=(ALL) NOPASSWD: ALL' > /private/etc/sudoers.d/admin

sysadminctl -addUser "$USERNAME" -admin -password "$USERPASS"

chsh -s /bin/bash $USERNAME
chsh -s /bin/bash root
