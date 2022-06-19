#!/bin/bash

set -euxo pipefail

TCC_SERVICES=(
    "'kTCCServiceDeveloperTool'"
    "'kTCCServiceAccessibility'"
    "'kTCCServiceSystemPolicyAllFiles'"
    "'kTCCServiceScreenCapture'"
    "'kTCCServiceMicrophone'"
    "'kTCCServicePostEvent'"
)

TCC_CLIENTS=(
    "'com.apple.Terminal',0"
    "'com.apple.CoreSimulator.SimulatorTrampoline',0"
    "'/bin/bash',1"
    "'/usr/libexec/sshd-keygen-wrapper',1"
)

cp '/Library/Application Support/com.apple.TCC/TCC.db' '/Volumes/Macintosh HD/Library/Application Support/com.apple.TCC/TCC.db'
for SERVICE in "${TCC_SERVICES[@]}"; do
    for CLIENT in "${TCC_CLIENTS[@]}"; do
        chroot '/Volumes/Macintosh HD' \
            sqlite3 '/Library/Application Support/com.apple.TCC/TCC.db' \
            "INSERT OR IGNORE INTO access VALUES(
                ${SERVICE}, ${CLIENT},
                2,3,1,NULL,NULL,0,'UNUSED',NULL,0,1646381108
            );"
    done
done
