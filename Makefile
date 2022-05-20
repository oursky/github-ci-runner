IMAGE_REPO=ghcr.io/oursky/github-ci-runner
GIT_COMMIT=$(shell git rev-parse HEAD)
IMAGE_TAR?=dist.local/image.tar
TAG?=latest

.PHONY: build
build:
	mkdir -p dist.local
	docker buildx build . \
		-o dest="${IMAGE_TAR}",type=oci,compression=uncompressed \
		-t "${IMAGE_REPO}:build"
	ls -lh dist.local

.PHONY: optimize
optimize:
	nerdctl image load -i "${IMAGE_TAR}"
	ctr-remote image optimize \
		--oci \
		--env RUNNER_NAME=x \
		--env RUNNER_TOKEN=x \
		--env RUNNER_ORG=x \
		--env RUNNER_HOME=/tmp \
		"${IMAGE_REPO}:build" \
		"${IMAGE_REPO}:build-opt"
	nerdctl image tag "${IMAGE_REPO}:build-opt" "${IMAGE_REPO}:build"
	nerdctl image save -o "${IMAGE_TAR}" "${IMAGE_REPO}:build"
	ls -lh dist.local

.PHONY: push
push:
	nerdctl image load -i "${IMAGE_TAR}"
	nerdctl image tag "${IMAGE_REPO}:build" "${IMAGE_REPO}:${TAG}"
	nerdctl image tag "${IMAGE_REPO}:build" "${IMAGE_REPO}:sha-$$(git rev-parse --short=10 HEAD)"
	nerdctl push "${IMAGE_REPO}:${TAG}"
	nerdctl push "${IMAGE_REPO}:sha-$$(git rev-parse --short=10 HEAD)"
