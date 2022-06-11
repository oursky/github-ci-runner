IMAGE_REPO=ghcr.io/oursky/github-ci-runner
GIT_COMMIT=$(shell git rev-parse HEAD)\
TAG?=latest

.PHONY: build
build:
	docker buildx build . -t "${IMAGE_REPO}:build" ${BUILDX_ARGS}
	docker images "${IMAGE_REPO}"

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

.PHONY: push
push:
	docker image tag "${IMAGE_REPO}:build" "${IMAGE_REPO}:${TAG}"
	docker image tag "${IMAGE_REPO}:build" "${IMAGE_REPO}:sha-$$(git rev-parse --short=10 HEAD)"
	docker push "${IMAGE_REPO}:${TAG}"
	docker push "${IMAGE_REPO}:sha-$$(git rev-parse --short=10 HEAD)"
