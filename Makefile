#!/usr/bin/env make -f

all:
	@echo "Usage: make [ shell | code | build ]"

clean: clean-shell clean-code

include mk/shell.mk
include mk/code.mk
include mk/build.mk
