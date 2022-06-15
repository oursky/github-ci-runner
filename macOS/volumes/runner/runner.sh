#!/bin/bash

set -euo pipefail

mkdir -p /Volumes/cache/Tools
ln -s /Volumes/cache/Tools ~/hostedtoolcache

mkdir -p ~/work

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export AGENT_TOOLSDIRECTORY=~/hostedtoolcache
export RUNNER_TOOL_CACHE=~/hostedtoolcache

test -e /Volumes/runner-setup/setup.sh && source /Volumes/runner-setup/setup.sh

COORDINATOR="http://$(swift /Volumes/runner/service.swift coordinator _github-action._tcp local)"
read TOKEN

CURL_ARGS=(
    "--retry" "5"
    "-H" "Authorization: Bearer $TOKEN"
)

(
    echo "waiting termination signal"
    PGID=$(ps -o pgid= $$ | grep -o '[0-9]*')
    curl -sS "${COORDINATOR}/wait" "${CURL_ARGS[@]}" --retry 100000 --retry-delay 1 || :
    echo "terminating runner"
    kill -SIGINT -$PGID
) &

RESP=$(curl -sSf "${COORDINATOR}/register" "${CURL_ARGS[@]}" --data-urlencode "name=$(hostname -s)" --data-urlencode "hostName=$(hostname)")
RUNNER_NAME=$(jq -n -r --argjson resp "$RESP" '$resp.name')
GITHUB_URL=$(jq -n -r --argjson resp "$RESP" '$resp.gitHubURL')
RUNNER_TOKEN=$(jq -n -r --argjson resp "$RESP" '$resp.token')
RUNNER_GROUP=$(jq -n -r --argjson resp "$RESP" '$resp.group')
RUNNER_LABELS=$(jq -n -r --argjson resp "$RESP" '$resp.labels')

cp -R actions-runner/ ~/runner

~/runner/config.sh --unattended --replace --ephemeral \
    --name "$RUNNER_NAME" \
    --url "$GITHUB_URL" \
    --token "$RUNNER_TOKEN" \
    --runnergroup "$RUNNER_GROUP" \
    --labels "$RUNNER_LABELS" \
    --work ~/work

RUNNER_ID=$(jq -r '.agentId' ~/runner/.runner)
curl -sS "${COORDINATOR}/update" "${CURL_ARGS[@]}" --data-urlencode "runnerID=$RUNNER_ID"


~/runner/run.sh
