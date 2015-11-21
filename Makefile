.PHONY: all user-space kernel-space rootfs clean realclean
# vim: tabstop=4 shiftwidth=4 softtabstop=4 ft=make


################################################################################
#	General Configuration
################################################################################

# Target CPU architecture.
ARCH?=x86_64

################################################################################
#		Software versions
################################################################################

# glibc
GLIBC_VER=2.22
export GLIBC_VER

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

# Gnu Make
MAKE_VER=4.1
export MAKE_VER

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

user-space: user
	$(MAKE) -C user

rootfs: rootfs/sys rootfs/proc rootfs/tmp kernel-space user-space 

kernel-space: kernel
	$(MAKE) -C kernel

realclean:
	$(MAKE) -C kernel realclean
	$(MAKE) -C user realclean

clean:
	$(MAKE) -C user clean
	$(MAKE) -C kernel clean

