.PHONY: $(BUILD_ROOT)/volumes/provisioning.dmg
$(BUILD_ROOT)/volumes/provisioning.dmg: .build-root
	hdiutil create \
		-ov \
		-volname provisioning \
		-layout GPTSPUD \
		-fs APFS \
		-format UDIF \
		-srcfolder volumes/provisioning/payload \
		-srcfolder volumes/provisioning/scripts \
		-srcfolder volumes/provisioning/provision.sh \
		-srcfolder volumes/provisioning/autorun.sh \
		"$(BUILD_ROOT)/volumes/provisioning"

.PHONY: $(BUILD_ROOT)/volumes/setup.dmg
$(BUILD_ROOT)/volumes/setup.dmg: .build-root
	hdiutil create \
		-ov \
		-volname setup \
		-layout GPTSPUD \
		-fs APFS \
		-format UDIF \
		-srcfolder volumes/setup \
		"$(BUILD_ROOT)/volumes/setup"

.PHONY: $(BUILD_ROOT)/volumes/cache.dmg
$(BUILD_ROOT)/volumes/cache.dmg: .build-root
	hdiutil create \
		-ov \
		-volname cache \
		-layout GPTSPUD \
		-fs APFS \
		-type UDIF \
		-size 10m \
		"$(BUILD_ROOT)/volumes/cache"
	hdiutil resize -size 50G "$(BUILD_ROOT)/volumes/cache.dmg"

.PHONY: $(BUILD_ROOT)/volumes/xcodes.sparseimage
$(BUILD_ROOT)/volumes/xcodes.sparseimage: .build-root
	test -f "$@" || hdiutil create \
		-ov \
		-volname xcodes \
		-layout GPTSPUD \
		-fs APFS \
		-type SPARSE \
		-size 10m \
		"$(BUILD_ROOT)/volumes/xcodes"
	hdiutil resize -size 200g "$(BUILD_ROOT)/volumes/xcodes.sparseimage"

	hdiutil attach "$(BUILD_ROOT)/volumes/xcodes.sparseimage"
	BUILD_ROOT="$(realpath $(BUILD_ROOT))" volumes/xcodes/extract.sh
	volumes/xcodes/optimize.sh
	hdiutil detach /Volumes/xcodes

.PHONY: $(BUILD_ROOT)/volumes/xcodes.dmg
$(BUILD_ROOT)/volumes/xcodes.dmg: .build-root $(BUILD_ROOT)/volumes/xcodes.sparseimage
	hdiutil resize -sectors min $(BUILD_ROOT)/volumes/xcodes.sparseimage
	hdiutil convert -ov -format UDRW -o $(BUILD_ROOT)/volumes/xcodes.dmg $(BUILD_ROOT)/volumes/xcodes.sparseimage

RUNNER_VER?=2.315.0

.PHONY: $(BUILD_ROOT)/volumes/runner.dmg
$(BUILD_ROOT)/volumes/runner.dmg: .build-root $(BUILD_ROOT)/assets/actions-runner
	hdiutil create \
		-ov \
		-volname runner \
		-layout GPTSPUD \
		-fs APFS \
		-format UDIF \
		-srcfolder volumes/runner/autorun.command \
		-srcfolder volumes/runner/runner.sh \
		-srcfolder "$(BUILD_ROOT)/assets/actions-runner" \
		"$(BUILD_ROOT)/volumes/runner"

$(BUILD_ROOT)/assets/actions-runner: .build-root
	mkdir -p $(BUILD_ROOT)/assets/actions-runner
	curl -L https://github.com/actions/runner/releases/download/v$(RUNNER_VER)/actions-runner-osx-arm64-$(RUNNER_VER).tar.gz \
		| tar xzC $(BUILD_ROOT)/assets/actions-runner
