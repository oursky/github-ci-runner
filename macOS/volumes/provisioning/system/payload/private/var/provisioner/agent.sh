#!/bin/bash

set -euxo pipefail

for VOL in /Volumes/*; do
    test -f "$VOL/autorun.command" && open "$VOL/autorun.command"
    test -f "$VOL/autorun.sh" && "$VOL/autorun.sh"
done
