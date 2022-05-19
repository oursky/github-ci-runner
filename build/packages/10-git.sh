#!/usr/bin/bash
set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/ubuntu20/20220508.1/images/linux/scripts/installers/git.sh

GIT_REPO="ppa:git-core/ppa"
GIT_LFS_REPO="https://packagecloud.io/install/repositories/github/git-lfs"

## Install git
add-apt-repository $GIT_REPO -y
apt-get install git -y
git --version
# Git version 2.35.2 introduces security fix that breaks action\checkout https://github.com/actions/checkout/issues/760
cat <<EOF >> /etc/gitconfig
[safe]
        directory = *
EOF

# Install git-lfs
curl -s $GIT_LFS_REPO/script.deb.sh | bash
apt-get install -y git-lfs

# Install git-ftp
apt-get install git-ftp -y

# Remove source repo's
add-apt-repository --remove $GIT_REPO
rm /etc/apt/sources.list.d/github_git-lfs.list

# Add well-known SSH host keys to known_hosts
ssh-keyscan -t rsa github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa gitlab.com >> /etc/ssh/ssh_known_hosts
