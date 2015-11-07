.PHONY: clean
# vim: tabstop=4 shiftwidth=4 softtabstop=4 ft=make

all: coreutils

CU_VER=8.24
coreutils:
	rm -rf coreutils-*
	wget http://ftp.gnu.org/gnu/coreutils/coreutils-$(CU_VER).tar.xz
	tar -xf coreutils-$(CU_VER).tar.xz
	rm coreutils-$(CU_VER).tar.xz
	mv coreutils-$(CU_VER) coreutils
	cd coreutils && ./configure
	$(MAKE) -C coreutils

	
clean:
	rm -rf coreutils

