.PHONY: all clean coreutils realclean
# vim: tabstop=4 shiftwidth=4 softtabstop=4 ft=make

all: coreutils

$(addprefix $(TARCACHE),coreutils-$(CU_VER).tar.xz):
	wget -P $(TARCACHE) http://ftp.gnu.org/gnu/coreutils/coreutils-$(CU_VER).tar.xz

coreutils-$(CU_VER): $(addprefix $(TARCACHE),coreutils-$(CU_VER).tar.xz)
	tar -xf $< -C .
	
# A file that's compiled all the way at the end.
coreutils-$(CU_VER)/man/tail.1: coreutils-$(CU_VER)
	cd coreutils-$(CU_VER) && ./configure
	$(MAKE) -C coreutils-$(CU_VER)

coreutils: coreutils-$(CU_VER)/man/tail.1

clean:
	$(MAKE) -C coreutils-$(CU_VER) clean

realclean:
	rm -rf coreutils-$(CU_VER)

