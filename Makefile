#!/usr/bin/env make -f

all: build code shell

clean: clean-shell clean-code

include mk/shell.mk
include mk/code.mk
include mk/build.mk
