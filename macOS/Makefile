.PHONY: help
help:
	@echo 'make [ipsw|vanilla|base]'

.PHONY: ipsw
ipsw:
	aria2c -x16 -s16 -o images/macOS.ipsw $$(bin/vmctl ipsw)

.PHONY: vanilla
vanilla: images/macOS.ipsw
	bin/vmctl install \
		--config config/installer-vanilla.json \
		--bundle instances/vanilla.bundle \
		--ipsw images/macOS.ipsw \
		--disk-size-gb 100

.PHONY: base
base:
	$(MAKE) -C volumes provisioning.dmg
	bin/vmctl clone instances/vanilla.bundle instances/base.bundle
	bin/vmctl start --config config/installer-base.json --bundle instances/base.bundle --recovery --key-script config/installer-script.json
	bin/vmctl start --config config/installer-base.json --bundle instances/base.bundle

.PHONY: runner
runner:
	$(MAKE) -C volumes setup.dmg cache.dmg
	bin/vmctl clone instances/base.bundle instances/runner.bundle
	bin/vmctl start --config config/runner-setup.json --bundle instances/runner.bundle

.PHONY: test
test:
	bin/vmctl clone instances/runner.bundle instances/test.bundle
	bin/vmctl start --config config/runner.json --bundle instances/test.bundle
