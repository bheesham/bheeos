.PHONY: all user-space kernel-space clean realclean

include build/versions.mk

################################################################################
#	General Configuration
################################################################################

# Target CPU architecture.
ARCH?=x86_64

# For software versions, see Make/versions.mk

################################################################################
#	Build stuff
################################################################################

TOP=$(realpath $(shell pwd))/
ifeq ($(TOP),/)
	$(error Top directory is invalid.)
endif

ROOTFS=$(addsuffix rootfs/,$(TOP))
KERNEL=$(addsuffix kernel/,$(TOP))
USER=$(addsuffix user/,$(TOP))
TARCACHE=$(addsuffix tarcache/,$(TOP))

export TOP
export ARCH

export ROOTFS
export KERNEL
export USER
export TARCACHE

all: tarcache rootfs kernel-space user-space

tarcache:
	mkdir -p $@

rootfs/sys: 
	mkdir -p $@
	sudo mount -t sysfs sysfs rootfs/sys

rootfs/proc:
	mkdir -p $@
	sudo mount -t proc proc rootfs/proc

rootfs/tmp:
	mkdir -p $@
	sudo mount -t tmpfs tmpfs rootfs/tmp

rootfs: rootfs/sys rootfs/proc rootfs/tmp 

kernel-space: kernel
	$(MAKE) -C kernel

user-space: user
	$(MAKE) -C user

realclean:
	$(MAKE) -C kernel realclean
	$(MAKE) -C user realclean

clean:
	$(MAKE) -C user clean
	$(MAKE) -C kernel clean

# vim: tabstop=4 shiftwidth=4 softtabstop=4 ft=make

