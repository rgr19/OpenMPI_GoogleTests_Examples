# -----------------------------------------------------------------------------
# CMake project wrapper Makefile ----------------------------------------------
# -----------------------------------------------------------------------------
ifndef CMAKE
	$(error CMAKE is not set)
endif


SHELL := /bin/bash
RM    := rm -rf
MKDIR := mkdir -p
BUILD := cmake-build
.DEFAULT_GOAL := all

clean: $(BUILD)
	@- $(RM) $(BUILD)
	@- $(RM) bin

all:  
	@- $(CMAKE) -H. -B$(BUILD) 
	@- $(MAKE) -C $(BUILD)  

distclean:
	@- $(CMAKE) -H. -B$(BUILD)
	@- $(MAKE) -C $(BUILD) clean || true
	@- $(RM) ./$(BUILD)


ifeq ($(findstring distclean,$(MAKECMDGOALS)),)
	$(MAKECMDGOALS): ./$(BUILD)/Makefile
	@ $(MAKE) -C $(BUILD) $(MAKECMDGOALS)
endif
