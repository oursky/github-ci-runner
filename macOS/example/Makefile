BUILD_ROOT ?= ../build

.PHONY: setup
setup:
	ln -F -s $(BUILD_ROOT)/instances/runner.bundle .
	ln -f -s $(BUILD_ROOT)/volumes/xcodes.dmg xcodes.dmg
	ln -f -s $(BUILD_ROOT)/volumes/runner.dmg runner.dmg
	cp -c $(BUILD_ROOT)/volumes/cache.dmg cache-1.dmg
	cp -c $(BUILD_ROOT)/volumes/cache.dmg cache-2.dmg
	cp coordinator-template.json coordinator.json

.PHONY: clean
clean:
	rm runner.bundle
	rm xcodes.dmg
	rm runner.dmg
	rm cache-1.dmg
	rm cache-2.dmg
	rm coordinator.json

.PHONY: start
start:
	../bin/coordinator -config coordinator.json
