#!/bin/bash -l

sudo chown -R runner:docker /runner
rsync -a /ci/runner/ /runner/

pushd ./setup
source ./setup.sh
popd

./dind.sh

exec /ci/kube-agent "$@"
