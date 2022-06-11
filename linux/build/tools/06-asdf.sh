#!/usr/bin/bash
set -euxo pipefail

mkdir -p /ci/tools
git clone https://github.com/asdf-vm/asdf.git /ci/tools/asdf --branch v0.10.0

# asdf does not work properly with symlinks
cat <<EOF >> /ci/bin/asdf
#!/bin/sh
exec /ci/tools/asdf/bin/asdf "\$@"
EOF
chmod +x /ci/bin/asdf
