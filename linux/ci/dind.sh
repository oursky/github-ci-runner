#!/bin/bash

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
