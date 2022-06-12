#!/bin/bash

set -euxo pipefail

sw_vers=$(sw_vers -productVersion)
sw_build=$(sw_vers -buildVersion)
plist="/Users/$USERNAME/Library/Preferences/com.apple.SetupAssistant.plist"
/usr/libexec/PlistBuddy \
    -c "Clear dict" \
    -c "Add DidSeeCloudSetup bool true" \
    -c "Add LastSeenCloudProductVersion string '$sw_vers'" \
    -c "Add LastSeenBuddyBuildVersion string '$sw_build'" \
    -c "Add GestureMovieSeen string none" \
    -c "Add DidSeePrivacy bool true" \
    -c "Add DidSeeTrueTonePrivacy bool true" \
    -c "Add DidSeeTouchIDSetup bool true" \
    -c "Add DidSeeSiriSetup bool true" \
    -c "Add DidSeeActivationLock bool true" \
    -c "Add DidSeeScreenTime bool true" \
    "$plist"
chown "$USERNAME:staff" "$plist"
