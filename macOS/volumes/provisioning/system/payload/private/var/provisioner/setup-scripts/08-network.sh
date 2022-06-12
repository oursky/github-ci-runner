#!/bin/bash

set -euxo pipefail

networksetup -setdnsservers Ethernet 8.8.8.8 8.8.4.4 1.1.1.1
