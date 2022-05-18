IMAGE_REPO=ghcr.io/oursky/github-ci-runner
GIT_COMMIT=$(shell git rev-parse HEAD)
TAG?=latest

.PHONY: build
build:
	docker buildx build . --platform linux/amd64 \
		-t ${IMAGE_REPO}:latest \
		-t ${IMAGE_REPO}:sha-$$(git rev-parse --short=10 HEAD)
	docker images ${IMAGE_REPO}:latest

.PHONY: push
push:
	docker tag ${IMAGE_REPO}:latest ${IMAGE_REPO}:${TAG}
	docker push ${IMAGE_REPO}:${TAG}
	docker push ${IMAGE_REPO}:sha-$$(git rev-parse --short=10 HEAD)
