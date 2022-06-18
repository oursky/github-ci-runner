VM_HOME ?= .

volumes:
	mkdir -p $(VM_HOME)/volumes

.PHONY: provisioning.dmg
provisioning.dmg: provisioning/provisioner.pkg provisioning/provision.sh provisioning/autorun.sh volumes
	hdiutil create \
		-ov \
		-volname provisioning \
		-layout GPTSPUD \
		-fs APFS \
		-format UDIF \
		-srcfolder provisioning/provisioner.pkg \
		-srcfolder provisioning/provision.sh \
		-srcfolder provisioning/autorun.sh \
		provisioning
	@ln -f provisioning.dmg $(VM_HOME)/volumes/ || true

.PHONY: provisioning/provisioner.pkg
provisioning/provisioner.pkg:
	pkgbuild \
		--identifier com.oursky.provisioner \
		--root "provisioning/system/payload" \
		--scripts "provisioning/system/scripts" \
		"provisioning/provisioner.pkg"

.PHONY: setup.dmg
setup.dmg: volumes
	hdiutil create \
		-ov \
		-volname setup \
		-layout GPTSPUD \
		-fs APFS \
		-format UDIF \
		-srcfolder setup \
		setup
	@ln -f setup.dmg $(VM_HOME)/volumes/ || true

.PHONY: cache.dmg
cache.dmg: volumes
	hdiutil create \
		-ov \
		-volname cache \
		-layout GPTSPUD \
		-fs APFS \
		-type UDIF \
		-size 10m \
		cache
	hdiutil resize -size 50G cache.dmg

	@ln -f cache.dmg $(VM_HOME)/volumes/ || true

xcodes.dmg: volumes
	hdiutil create \
		-ov \
		-volname xcodes \
		-layout GPTSPUD \
		-fs APFS \
		-type SPARSE \
		-size 100G \
		xcodes
	hdiutil attach xcodes.sparseimage
	xcodes/extract.sh
	xcodes/optimize.sh
	hdiutil detach /Volumes/xcodes
	hdiutil resize -sectors min xcodes.sparseimage
	hdiutil convert -ov -format UDRW -o xcodes.dmg xcodes.sparseimage
	rm xcodes.sparseimage

	@ln -f xcodes.dmg $(VM_HOME)/volumes/ || true

RUNNER_VER?=2.293.0

.PHONY: runner.dmg
runner.dmg: runner/actions-runner volumes
	hdiutil create \
		-ov \
		-volname runner \
		-layout GPTSPUD \
		-fs APFS \
		-format UDIF \
		-srcfolder runner \
		runner
	@ln -f runner.dmg $(VM_HOME)/volumes/ || true

runner/actions-runner:
	mkdir -p runner/actions-runner
	curl -L https://github.com/actions/runner/releases/download/v$(RUNNER_VER)/actions-runner-osx-arm64-$(RUNNER_VER).tar.gz \
		| tar xzC runner/actions-runner
