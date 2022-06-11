#!/usr/bin/bash
set -euxo pipefail

sed -i 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/azure\.archive\.ubuntu\.com\/ubuntu\//g' /etc/apt/sources.list
sed -i 's/http:\/\/[a-z][a-z]\.archive\.ubuntu\.com\/ubuntu\//http:\/\/azure\.archive\.ubuntu\.com\/ubuntu\//g' /etc/apt/sources.list

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

curl -O "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
dpkg -i packages-microsoft-prod.deb
curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

add-apt-repository universe

apt-fast update
apt-fast dist-upgrade

cat <<EOF >> /etc/profile.d/01-ci-bin.sh
export DEBIAN_FRONTEND=noninteractive
EOF
