.PHONY: all user-space kernel-space clean realclean
# vim: tabstop=4 shiftwidth=4 softtabstop=4 ft=make


################################################################################
#	General Configuration
################################################################################

# Target CPU architecture.
ARCH?=x86_64


################################################################################
#		Software versions
################################################################################

# gradm
GRA_VER=3.1-201507191652
export GRA_VER

# grsecurity
GRS_VER=3.1-4.2.5-201511090815
export GRS_VER

# Linux kernel version.
# Hah, liver.
LI_VER=4.2.5
export LI_VER

# Coreutils
CU_VER=8.24
export CU_VER

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

all: tarcache rootfs

tarcache:
	mkdir -p tarcache

rootfs: kernel-space user-space
	mkdir -p rootfs
	mkdir -p rootfs/dev rootfs/proc \
			 rootfs/sys rootfs/tmp

user-space: user
	$(MAKE) -C user

kernel-space: kernel
	$(MAKE) -C kernel

realclean:
	$(MAKE) -C kernel realclean
	$(MAKE) -C user realclean

clean:
	$(MAKE) -C user clean
	$(MAKE) -C kernel clean

