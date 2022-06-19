#!/bin/bash

set -euxo pipefail

systemsetup -setremotelogin on

ssh-keyscan -t rsa github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa gitlab.com >> /etc/ssh/ssh_known_hosts
