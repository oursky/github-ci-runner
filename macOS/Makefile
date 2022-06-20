BUILD_ROOT ?= ./build

.PHONY: .build-root
.build-root:
	@mkdir -p $(BUILD_ROOT)
	@mkdir -p $(BUILD_ROOT)/assets
	@mkdir -p $(BUILD_ROOT)/config
	@mkdir -p $(BUILD_ROOT)/instances
	@mkdir -p $(BUILD_ROOT)/volumes
	@mkdir -p $(BUILD_ROOT)/xips

.PHONY: help
help:
	@echo 'make [ipsw|vanilla|base|runner]'

.PHONY: ipsw
ipsw: .build-root
	aria2c -x16 -s16 -o $(BUILD_ROOT)/assets/macOS.ipsw $$(bin/vmctl ipsw)

.PHONY: vanilla
vanilla: .build-root $(BUILD_ROOT)/assets/macOS.ipsw
	cp config/installer-vanilla.json $(BUILD_ROOT)/config/
	bin/vmctl install \
		--config $(BUILD_ROOT)/config/installer-vanilla.json \
		--bundle $(BUILD_ROOT)/instances/vanilla.bundle \
		--ipsw $(BUILD_ROOT)/assets/macOS.ipsw \
		--disk-size-gb 100

.PHONY: base
base: .build-root $(BUILD_ROOT)/volumes/provisioning.dmg
	cp config/installer-base.json $(BUILD_ROOT)/config/
	bin/vmctl clone $(BUILD_ROOT)/instances/vanilla.bundle $(BUILD_ROOT)/instances/base.bundle
	bin/vmctl start --config $(BUILD_ROOT)/config/installer-base.json --bundle $(BUILD_ROOT)/instances/base.bundle \
		--recovery --key-script config/installer-script.json
	bin/vmctl start --config $(BUILD_ROOT)/config/installer-base.json --bundle $(BUILD_ROOT)/instances/base.bundle

.PHONY: runner
runner: .build-root $(BUILD_ROOT)/volumes/setup.dmg $(BUILD_ROOT)/volumes/cache.dmg $(BUILD_ROOT)/volumes/runner.dmg
	test -e $(BUILD_ROOT)/volumes/xcodes.dmg
	cp config/runner-setup.json $(BUILD_ROOT)/config/
	bin/vmctl clone $(BUILD_ROOT)/instances/base.bundle $(BUILD_ROOT)/instances/runner.bundle
	bin/vmctl start --config $(BUILD_ROOT)/config/runner-setup.json --bundle $(BUILD_ROOT)/instances/runner.bundle

.PHONY: xcodes
xcodes: .build-root $(BUILD_ROOT)/volumes/xcodes.dmg

.PHONY: test-base
test-base: .build-root
	cp config/runner-test.json $(BUILD_ROOT)/config/
	bin/vmctl clone $(BUILD_ROOT)/instances/base.bundle $(BUILD_ROOT)/instances/test.bundle
	bin/vmctl start --config $(BUILD_ROOT)/config/runner-test.json --bundle $(BUILD_ROOT)/instances/test.bundle

.PHONY: test-runner
test-runner: .build-root
	cp config/runner-test.json $(BUILD_ROOT)/config/
	bin/vmctl clone $(BUILD_ROOT)/instances/runner.bundle $(BUILD_ROOT)/instances/test.bundle
	bin/vmctl start --config $(BUILD_ROOT)/config/runner-test.json --bundle $(BUILD_ROOT)/instances/test.bundle

include volumes.mk
