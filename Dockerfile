# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=target=/build,source=/build,rw=true cd /build && ./setup-env.sh && ./setup-dpkg.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/01-base.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/02-git.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/03-docker.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/04-browsers.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./packages/05-blackbox.sh
RUN --mount=target=/build,source=/build,rw=true cd /build && ./setup-runner.sh && ./cleanup.sh

USER runner
ENV HOME=/home/runner

COPY --chown=runner: --link ci/ /ci/

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
WORKDIR "/ci"
CMD ["/ci/startup.sh"]
