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

provisioning/provisioner.pkg: $(shell find provisioning/system) #$(wildcard provisioning/system/**/*.*)
	pkgbuild \
		--identifier com.oursky.provisioner \
		--root "provisioning/system/payload" \
		--scripts "provisioning/system/scripts" \
		"provisioning/provisioner.pkg"
