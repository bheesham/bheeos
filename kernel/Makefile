.PHONY: clean linux

linux:
	$(MAKE) -C linux allyesconfig 
	$(MAKE) -C linux kvmconfig
	$(MAKE) -C linux all

clean:
	$(MAKE) -C linux clean

