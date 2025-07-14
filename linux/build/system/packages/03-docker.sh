#!/usr/bin/bash
set -euxo pipefail

apt-fast install \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    supervisor
usermod -aG docker runner

# https://github.com/docker-library/docker/blob/master/20.10/dind/Dockerfile
addgroup --system dockremap; \
	adduser --system --group dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

DIND_COMMIT=42b1175eda071c0e9121e1d64345928384a93df1

curl -o /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"
chmod +x /usr/local/bin/dind

