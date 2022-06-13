#!/bin/bash
set -euxo pipefail

# https://github.com/actions/virtual-environments/blob/macOS-12/20220605.1/images/macos/provision/core/git.sh

git config --global --add safe.directory "*"
git lfs install
sudo git lfs install --system

git config --global advice.pushUpdateRejected false
git config --global advice.pushNonFFCurrent false
git config --global advice.pushNonFFMatching false
git config --global advice.pushAlreadyExists false
git config --global advice.pushFetchFirst false
git config --global advice.pushNeedsForce false
git config --global advice.statusHints false
git config --global advice.statusUoption false
git config --global advice.commitBeforeMerge false
git config --global advice.resolveConflict false
git config --global advice.implicitIdentity false
git config --global advice.detachedHead false
git config --global advice.amWorkDir false
git config --global advice.rmHints false
