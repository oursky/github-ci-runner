# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=target=/build,source=/build,rw=true cd /build && ./setup-env.sh && ./setup-dpkg.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/00-base-lib.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/01-base-common.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/02-base-cmd.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/10-git.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/20-docker.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/30-browsers.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/40-blackbox.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./setup-runner.sh && ./cleanup.sh

USER runner
ENV HOME=/home/runner

COPY --chown=runner: --link ci/ /ci/

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
WORKDIR "/ci"
CMD ["/ci/startup.sh"]
