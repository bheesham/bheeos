.PHONY: clean all

gradm/gradm:
	wget https://grsecurity.net/stable/gradm-$(GRA_VER).tar.gz
	tar -xf gradm-$(GRA_VER).tar.gz
	rm gradm-$(GRA_VER).tar.gz
	$(MAKE) -C gradm

clean:
	rm -rf gradm-$(GRA_VER).tar.gz
	$(MAKE) -C gradm clean

