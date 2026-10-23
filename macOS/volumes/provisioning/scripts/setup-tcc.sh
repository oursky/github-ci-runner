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

TCC_DB='/Volumes/Data/Library/Application Support/com.apple.TCC/TCC.db'

mkdir -p "${TCC_DB%/*}"
cp '/Library/Application Support/com.apple.TCC/TCC.db' "$TCC_DB"
for SERVICE in "${TCC_SERVICES[@]}"; do
    for CLIENT in "${TCC_CLIENTS[@]}"; do
        '/Volumes/Macintosh HD/usr/bin/sqlite3' "$TCC_DB" \
        "INSERT OR REPLACE INTO access (
            service, client, client_type, auth_value, auth_reason, auth_version, indirect_object_identifier_type, flags
        ) VALUES(${SERVICE}, ${CLIENT}, 2, 3, 1, 0, 0);"
    done
done
