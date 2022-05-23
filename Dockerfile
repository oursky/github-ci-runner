# syntax=docker/dockerfile:1.4

#### Tools
FROM ubuntu:22.04 AS tools-base
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl git sudo make unzip
RUN adduser --disabled-password --gecos "" --uid 1000 runner && \
    usermod -aG sudo runner && \
    echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/runner && \
    mkdir /ci && \
    chown runner:runner /ci

USER runner
RUN mkdir -p /ci/bin
ENV PATH="${PATH}:/ci/bin"

FROM tools-base AS tools-docker
RUN --mount=target=/build/script.sh,source=/build/tools/01-docker.sh /build/script.sh

FROM tools-base AS tools-blackbox
RUN --mount=target=/build/script.sh,source=/build/tools/02-blackbox.sh /build/script.sh

FROM tools-base AS tools-android
RUN --mount=target=/build/script.sh,source=/build/tools/03-android.sh /build/script.sh

FROM tools-base AS tools-gcloud
RUN --mount=target=/build/script.sh,source=/build/tools/04-gcloud.sh /build/script.sh

FROM tools-base AS tools
COPY --chown=1000:100 --link ci/ /ci/
COPY --from=tools-docker --link /ci/ /ci/
COPY --from=tools-blackbox --link /ci/ /ci/
COPY --from=tools-android --link /ci/ /ci/
COPY --from=tools-gcloud --link /ci/ /ci/

### System
FROM ubuntu:22.04 AS system
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /build
RUN --mount=target=/build/script.sh,source=/build/system/setup-env.sh /build/script.sh
RUN --mount=target=/build/script.sh,source=/build/system/setup-dpkg.sh /build/script.sh
RUN --mount=target=/build/script.sh,source=/build/system/packages/01-base.sh /build/script.sh
RUN --mount=target=/build/script.sh,source=/build/system/packages/02-git.sh /build/script.sh
RUN --mount=target=/build/script.sh,source=/build/system/packages/03-docker.sh /build/script.sh
RUN --mount=target=/build/script.sh,source=/build/system/packages/04-browsers.sh /build/script.sh
RUN --mount=target=/build/script.sh,source=/build/system/packages/05-zstd.sh /build/script.sh
RUN --mount=target=/build/script.sh,source=/build/system/setup-runner.sh /build/script.sh
RUN --mount=target=/build/script.sh,source=/build/system/cleanup.sh /build/script.sh

### Runner
FROM scratch

COPY --from=system --link / /
COPY --from=tools --link /ci/ /ci/

RUN --mount=target=/build/script.sh,source=/build/tools/setup-env.sh /build/script.sh

USER runner
ENV HOME=/home/runner
ENV PATH="${PATH}:/ci/bin"

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
WORKDIR "/ci"
CMD ["/ci/startup.sh"]
