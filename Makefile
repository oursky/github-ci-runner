.PHONY: build
build:
	docker buildx build . --platform linux/amd64 -t oursky-ci-runner:latest
