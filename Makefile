
SERIES ?= noble
DESTDIR ?= install

all:
	mkdir -p $(DESTDIR)
	make install/cidata
	make install/dtb
	make install/grub
	make meta
	find .

install/cidata:
	mkdir -p $(DESTDIR)/cidata
	cp user-data $(DESTDIR)/cidata/
	cp meta-data $(DESTDIR)/cidata/
	touch $(DESTDIR)/cidata/vendor-data

install/dtb:
	rm -rf build
	mkdir build
	cd build && wget https://launchpad.net/~sifive-sandbox/+archive/ubuntu/linux/+files/linux-image-6.6.21-35-g29ac17434e52-eswin_6.6.21-35-g29ac17434e52-0ubuntu0~ppa13_all.deb
	cd build && dpkg -x linux-image*.deb linux-modules/
	mkdir -p $(DESTDIR)/dtb
	cp -r ./build/linux-modules/usr/lib/firmware/*-eswin/device-tree/* \
	$(DESTDIR)/dtb
	rm -rf build

install/grub:
	rm -rf build
	mkdir build
	cd build && wget http://ftp.us.debian.org/debian/pool/main/g/grub2/grub-efi-riscv64-unsigned_2.12-5_riscv64.deb
	cd build && dpkg -x grub-efi-riscv64-unsigned*.deb grub/
	mkdir -p $(DESTDIR)/grub
	cp ./build/grub/usr/lib/grub/riscv64-efi/monolithic/grubriscv64.efi $(DESTDIR)/grub/
	cp grub.cfg $(DESTDIR)/grub/
	rm -rf build

meta:
	mkdir -p $(DESTDIR)/meta
	cp gadget.yaml $(DESTDIR)/meta/

image:
	sudo ubuntu-image --workdir /tmp/workdir classic image-definition.yaml

image-debug:
	sudo rm -rf /tmp/workdir
	sudo ubuntu-image --workdir /tmp/workdir --debug classic image-definition.yaml
