provisioning.dmg: provisioning/provisioner.pkg provisioning/provision.sh provisioning/autorun.sh
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

provisioning/provisioner.pkg: $(shell find provisioning/system)
	pkgbuild \
		--identifier com.oursky.provisioner \
		--root "provisioning/system/payload" \
		--scripts "provisioning/system/scripts" \
		"provisioning/provisioner.pkg"

setup.dmg: $(shell find setup)
	hdiutil create \
		-ov \
		-volname setup \
		-layout GPTSPUD \
		-fs APFS \
		-format UDIF \
		-srcfolder setup \
		setup

cache.dmg:
	hdiutil create \
		-ov \
		-volname cache \
		-layout GPTSPUD \
		-fs APFS \
		-type UDIF \
		-size 10m \
		cache
	hdiutil resize -size 50G cache.dmg

