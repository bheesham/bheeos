.PHONY: all clean 

# NOTE: The versions of grsecurity and linux need to match up.
# NOTE: The versions of gradm and grsecurity need to match up.

all: linux/arch/x86/boot/bzImage

GRA_VER=3.1-201507191652
export GRA_VER
gradm/gradm/gradm:
	$(MAKE) -C gradm

GRS_VER=3.1-4.2.5-201511021814
export GRS_VER
grsecurity/patch: 
	$(MAKE) -C grsecurity

LI_VER=4.2
export LI_VER
linux/arch/x86/boot/bzImage: grsecurity/patch gradm/gradm/gradm
	cd linux && git checkout tags/v$(LI_VER)
	cd linux && patch -f -p1 < ../grsecurity/patch
	$(MAKE) -C linux allyesconfig 
	$(MAKE) -C linux kvmconfig
	$(MAKE) -C linux all

clean:
	$(MAKE) -C gradm clean
	$(MAKE) -C grsecurity clean
	rm -rf linux
	git submodule update --init

