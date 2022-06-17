.PHONY: help
help:
	@echo 'make [ipsw|vanilla|base]'

instances:
	mkdir -p ~/.vms/instances

.PHONY: ipsw
ipsw:
	@mkdir -p ~/.vms/images
	aria2c -x16 -s16 -o ~/.vms/images/macOS.ipsw $$(bin/vmctl ipsw)

.PHONY: vanilla
vanilla: images/macOS.ipsw instances
	bin/vmctl install \
		--config config/installer-vanilla.json \
		--bundle ~/.vms/instances/vanilla.bundle \
		--ipsw ~/.vms/images/macOS.ipsw \
		--disk-size-gb 100

.PHONY: base
base: instances
	$(MAKE) -C volumes provisioning.dmg
	bin/vmctl clone ~/.vms/instances/vanilla.bundle ~/.vms/instances/base.bundle
	bin/vmctl start --config config/installer-base.json --bundle ~/.vms/instances/base.bundle --recovery --key-script config/installer-script.json
	bin/vmctl start --config config/installer-base.json --bundle ~/.vms/instances/base.bundle

.PHONY: runner
runner: instances
	$(MAKE) -C volumes setup.dmg cache.dmg xcodes.dmg
	bin/vmctl clone ~/.vms/instances/base.bundle ~/.vms/instances/runner.bundle
	bin/vmctl start --config config/runner-setup.json --bundle ~/.vms/instances/runner.bundle

.PHONY: test
test: instances
	bin/vmctl clone ~/.vms/instances/runner.bundle ~/.vms/instances/test.bundle
	bin/vmctl start --config config/runner.json --bundle ~/.vms/instances/test.bundle
