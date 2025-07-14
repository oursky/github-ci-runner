#!/usr/bin/bash
set -euxo pipefail

echo "APT::Acquire::Retries \"10\";" > /etc/apt/apt.conf.d/80retries
echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes
echo "APT::Get::Never-Include-Phased-Updates \"1\";" > /etc/apt/apt.conf.d/99phased-updates
cat <<EOF >> /etc/apt/apt.conf.d/10dpkg-options
Dpkg::Options {
  "--force-confdef";
  "--force-confold";
}
EOF

apt-get -yq update

apt-get -yq install \
  curl \
  wget \
  aria2

curl 'https://raw.githubusercontent.com/ilikenwf/apt-fast/master/quick-install.sh' | bash -
cat <<EOF >> /etc/apt-fast.conf
DOWNLOADBEFORE=true
EOF

apt-fast install --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  software-properties-common

add-apt-repository universe

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-fast update
apt-fast dist-upgrade

cat <<EOF >> /etc/profile.d/01-ci-bin.sh
export DEBIAN_FRONTEND=noninteractive
EOF
