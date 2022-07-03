#!/bin/bash -l

export HOME=~runner
exec /var/runner/kube-agent --config /etc/runner/agent.toml
