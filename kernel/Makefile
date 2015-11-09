.PHONY: all clean realclean

all: linux-$(LI_VER)/arch/x86/boot/bzImage gradm/gradm

$(addprefix $(TARCACHE),gradm-$(GRA_VER).tar.gz):
	wget -P $(TARCACHE) https://grsecurity.net/stable/gradm-$(GRA_VER).tar.gz

gradm: $(addprefix $(TARCACHE),gradm-$(GRA_VER).tar.gz)
	tar -xf $< -C .

gradm/gradm: gradm
	$(MAKE) -C gradm

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

linux-$(LI_VER)/arch/x86/boot/bzImage: linux-$(LI_VER)/localversion-grsec
	$(MAKE) -C linux-$(LI_VER) allyesconfig 
	$(MAKE) -C linux-$(LI_VER) kvmconfig 
	$(MAKE) -C linux-$(LI_VER) all 

clean: grsecurity/patch
	$(MAKE) -C gradm clean
	$(MAKE) -C linux-$(LI_VER) clean

realclean:
	rm -rf gradm
	rm -rf grsecurity
	rm -rf linux-$(LI_VER)

