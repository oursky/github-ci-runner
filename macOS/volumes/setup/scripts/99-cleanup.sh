#!/bin/bash

sudo rm -rf /tmp/*

sudo mdutil -E /
sudo log stream | grep -q -E 'mds.*Released.*BackgroundTask' || true
