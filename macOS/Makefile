VM_HOME ?= .

.PHONY: help
help:
	@echo 'make [ipsw|vanilla|base]'

.PHONY: instances
instances:
	mkdir -p $(VM_HOME)/instances

.PHONY: ipsw
ipsw:
	@mkdir -p $(VM_HOME)/images
	aria2c -x16 -s16 -o $(VM_HOME)/images/macOS.ipsw $$(bin/vmctl ipsw)

.PHONY: vanilla
vanilla: images/macOS.ipsw instances
	bin/vmctl install \
		--config config/installer-vanilla.json \
		--bundle $(VM_HOME)/instances/vanilla.bundle \
		--ipsw $(VM_HOME)/images/macOS.ipsw \
		--disk-size-gb 100

.PHONY: base
base: instances
	$(MAKE) -C volumes provisioning.dmg
	bin/vmctl clone $(VM_HOME)/instances/vanilla.bundle $(VM_HOME)/instances/base.bundle
	bin/vmctl start --config config/installer-base.json --bundle $(VM_HOME)/instances/base.bundle --recovery --key-script config/installer-script.json
	bin/vmctl start --config config/installer-base.json --bundle $(VM_HOME)/instances/base.bundle

.PHONY: runner
runner: instances
	$(MAKE) -C volumes setup.dmg cache.dmg xcodes.dmg
	bin/vmctl clone $(VM_HOME)/instances/base.bundle $(VM_HOME)/instances/runner.bundle
	bin/vmctl start --config config/runner-setup.json --bundle $(VM_HOME)/instances/runner.bundle

.PHONY: test
test: instances
	bin/vmctl clone $(VM_HOME)/instances/vanilla.bundle $(VM_HOME)/instances/base.bundle
	bin/vmctl start --config config/installer-base.json --bundle $(VM_HOME)/instances/base.bundle