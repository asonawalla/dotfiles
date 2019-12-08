#!/usr/bin/env make -f

all:
	@echo "Usage: make [ build | code | shell | python ]"

clean: clean-shell clean-code

include mk/shell.mk
include mk/code.mk
include mk/build.mk
