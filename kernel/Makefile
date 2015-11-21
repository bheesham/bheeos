.PHONY: all clean realclean glibc

all: linux-$(LI_VER)/localversion-grsec glibc-build

$(addprefix $(TARCACHE),grsecurity-$(GRS_VER).patch):
	wget -P $(TARCACHE) https://grsecurity.net/test/grsecurity-$(GRS_VER).patch

grsecurity/patch: $(addprefix $(TARCACHE),grsecurity-$(GRS_VER).patch)
	@mkdir -p grsecurity
	cp $< grsecurity/patch

$(addprefix $(TARCACHE),linux-$(LI_VER).tar.xz):
	wget -P $(TARCACHE) https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-$(LI_VER).tar.xz

linux-$(LI_VER): $(addprefix $(TARCACHE),linux-$(LI_VER).tar.xz)
	tar -xf $< -C .

linux-$(LI_VER)/localversion-grsec: linux-$(LI_VER) grsecurity/patch
	test -s $@ || patch -d linux-$(LI_VER) -p1 < grsecurity/patch

$(addprefix $(TARCACHE),glibc-$(GLIBC_VER).tar.bz2):
	wget -P $(TARCACHE) http://ftp.gnu.org/gnu/glibc/glibc-$(GLIBC_VER).tar.bz2

glibc-$(GLIBC_VER): $(addprefix $(TARCACHE),glibc-$(GLIBC_VER).tar.bz2)
	tar -xf $< -C .

glibc-build: glibc-$(GLIBC_VER)
	mkdir -p glibc-build
	cd glibc-build && ./../glibc-$(GLIBC_VER)/configure \
		--prefix=$(addprefix $(ROOTFS),usr)

clean:
	$(MAKE) -C linux-$(LI_VER) clean
	$(MAKE) -C glibc-$(GLIBC) clean

realclean:
	rm -rf grsecurity
	rm -rf linux-$(LI_VER)
	rm -rf glibc-*

