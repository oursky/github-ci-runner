# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=target=/build,source=/build,rw=true cd /build && ./setup.sh

USER runner
ENV HOME=/home/runner

COPY --chown=runner: --link ci/ /ci/

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
WORKDIR "/ci"
CMD ["/ci/startup.sh"]
