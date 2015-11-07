.PHONY: all user-space kernel-space clean
# vim: tabstop=4 shiftwidth=4 softtabstop=4 ft=make

ARCH?=x86_64
TOP=$(realpath $(shell pwd))/
ifeq ($(TOP),/)
	$(error Top directory is invalid.)
endif

ROOTFS=$(addsuffix ROOTFS,$(TOP)) 
USER=$(addsuffix user,$(TOP)) 

export TOP
export ARCH

all: rootfs

rootfs: user-space kernel-space
	mkdir -p rootfs
	mkdir -p rootfs/dev rootfs/proc \
			 rootfs/sys rootfs/tmp

user-space: user
	$(MAKE) -C user

kernel-space: kernel
	$(MAKE) -C kernel

clean:
	$(MAKE) -C user clean
	$(MAKE) -C kernel clean

