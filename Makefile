TARGETS := $(shell ls scripts)
ARCH ?= $(shell uname -m)

.dapper:
	@echo Downloading dapper
	@curl -sL https://releases.rancher.com/dapper/latest/dapper-`uname -s`-`uname -m` > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

$(TARGETS): .dapper
	./.dapper -f Dockerfile.dapper.$(ARCH) $@

trash: .dapper
	./.dapper -f Dockerfile.dapper.$(ARCH) -m bind trash

trash-keep: .dapper
	./.dapper -f Dockerfile.dapper.$(ARCH) -m bind trash -k

deps: trash

.DEFAULT_GOAL := ci

.PHONY: $(TARGETS)
