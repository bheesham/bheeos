.PHONY: all clean realclean
# vim: tabstop=4 shiftwidth=4 softtabstop=4 ft=make

all: $(addprefix $(ROOTFS),usr/bin/make) $(addprefix $(ROOTFS),usr/bin/ls) \
		$(addprefix $(ROOTFS),usr/sbin/gradm)

$(addprefix $(TARCACHE),make-$(MAKE_VER).tar.bz2):
	wget -P $(TARCACHE) http://ftp.gnu.org/gnu/make/make-$(MAKE_VER).tar.bz2

make-$(MAKE_VER): $(addprefix $(TARCACHE),make-$(MAKE_VER).tar.bz2)
	tar -xf $< -C .

make-$(MAKE_VER)/config.status: make-$(MAKE_VER)
	cd make-$(MAKE_VER) && autoreconf -ivf
	cd make-$(MAKE_VER) && ./configure \
		--prefix=$(addprefix $(ROOTFS),usr) \
		--host=x86_64-linux-gnu \
		--build=x86_64-unknown-linux-gnu \
		--bindir=$(addprefix $(ROOTFS),usr/bin) \
		--libdir=$(addprefix $(ROOTFS),usr/lib) \
		--includedir=$(addprefix $(ROOTFS),usr/include) \

$(addprefix $(ROOTFS),usr/bin/make): make-$(MAKE_VER)/config.status
	$(MAKE) -C make-$(MAKE_VER)
	$(MAKE) -C make-$(MAKE_VER) install

$(addprefix $(TARCACHE),coreutils-$(CU_VER).tar.xz):
	wget -P $(TARCACHE) http://ftp.gnu.org/gnu/coreutils/coreutils-$(CU_VER).tar.xz

coreutils-$(CU_VER): $(addprefix $(TARCACHE),coreutils-$(CU_VER).tar.xz)
	tar -xf $< -C .

coreutils-$(CU_VER)/config.status: coreutils-$(CU_VER)
	cd coreutils-$(CU_VER) && autoreconf -ivf
	cd coreutils-$(CU_VER) && ./configure \
		--prefix=$(addprefix $(ROOTFS),usr) \
		--host=x86_64-linux-gnu \
		--build=x86_64-unknown-linux-gnu \
		--bindir=$(addprefix $(ROOTFS),usr/bin) \
		--libdir=$(addprefix $(ROOTFS),usr/lib) \
		--includedir=$(addprefix $(ROOTFS),usr/include)

$(addprefix $(ROOTFS),usr/bin/ls): coreutils-$(CU_VER)/config.status
	$(MAKE) -C coreutils-$(CU_VER)
	$(MAKE) -C coreutils-$(CU_VER) install

$(addprefix $(TARCACHE),gradm-$(GRA_VER).tar.gz):
	wget -P $(TARCACHE) https://grsecurity.net/stable/gradm-$(GRA_VER).tar.gz

gradm: $(addprefix $(TARCACHE),gradm-$(GRA_VER).tar.gz)
	tar -xf $< -C .

$(addprefix $(ROOTFS),usr/sbin/gradm): gradm
	$(MAKE) -C gradm
	$(MAKE) -C gradm install DESTDIR=$(addprefix $(ROOTFS),usr)

clean:
	$(MAKE) -C gradm clean
	$(MAKE) -C make-$(MAKE_VER) clean
	$(MAKE) -C coreutils-$(CU_VER) clean

realclean:
	rm -rf gradm
	rm -rf make-$(MAKE_VER)
	rm -rf coreutils-$(CU_VER)

