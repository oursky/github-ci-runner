provisioning.dmg: provisioning/provision.sh provisioning/provisioner.pkg
	hdiutil create \
		-ov \
		-volname provisioning \
		-layout GPTSPUD \
		-fs APFS \
		-format UDIF \
		-srcfolder provisioning/provision.sh \
		-srcfolder provisioning/provisioner.pkg \
		provisioning

provisioning/provisioner.pkg: $(shell find provisioning/system) #$(wildcard provisioning/system/**/*.*)
	pkgbuild \
		--identifier com.oursky.provisioner \
		--root "provisioning/system/payload" \
		--scripts "provisioning/system/scripts" \
		"provisioning/provisioner.pkg"
