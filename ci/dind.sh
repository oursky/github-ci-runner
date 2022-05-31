#!/bin/bash

# https://github.com/docker-library/docker/blob/master/20.10/dind/dockerd-entrypoint.sh

if ! iptables -nL > /dev/null 2>&1; then
  # if iptables fails to run, chances are high the necessary kernel modules aren't loaded (perhaps the host is using nftables with the translating "iptables" wrappers, for example)
  # https://github.com/docker-library/docker/issues/350
  # https://github.com/moby/moby/issues/26824
  modprobe ip_tables || :
fi

sudo tee /etc/supervisor/conf.d/dockerd.conf <<EOF
[program:dockerd]
command=dind dockerd ${DOCKERD_ARGS}
autostart=true
autorestart=true
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
EOF

sudo /usr/bin/supervisord -n &
