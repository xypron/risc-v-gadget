
SERIES ?= ocular
DESTDIR ?= install

all:
	mkdir -p $(DESTDIR)
	make install/dtb
	make install/u-boot-sifive-unmatched
	make install/u-boot-starfive
	make install/u-boot-microchip
	make install/grub
	make meta
	find $$(pwd)/../..

meta:
	mkdir -p $(DESTDIR)/meta
	cp gadget.yaml $(DESTDIR)/meta/

install/dtb:
	rm -rf build
	mkdir build
	cd build && pull-lp-debs linux-riscv '' $(SERIES)
	cd build && dpkg -x linux-modules*.deb linux-modules/
	mkdir -p $(DESTDIR)/dtb
	cp -r ./build/linux-modules/lib/firmware/*-generic/device-tree/* \
	$(DESTDIR)/dtb
	rm -rf build

install/grub:
	rm -rf build
	mkdir build
	cd build && wget http://ftp.us.debian.org/debian/pool/main/g/grub2/grub-efi-riscv64-unsigned_2.12-3_riscv64.deb
	cd build && dpkg -x grub-efi-riscv64-unsigned*.deb grub/
	mkdir -p $(DESTDIR)/grub
	cp ./build/grub/usr/lib/grub/riscv64-efi/monolithic/grubriscv64.efi $(DESTDIR)/grub/
	cp grub.cfg $(DESTDIR)/grub/
	rm -rf build

install/u-boot-sifive-unmatched:
	rm -rf build
	mkdir build
	rm -rf build/u-boot-sifive*
	cd build && pull-lp-debs u-boot-sifive '' $(SERIES)
	cd build && dpkg -x u-boot-sifive*.deb u-boot-sifive/
	mkdir -p $(DESTDIR)/u-boot-sifive-unmatched
	cp ./build/u-boot-sifive/usr/lib/u-boot/sifive_unmatched/u-boot-spl.bin \
	$(DESTDIR)/u-boot-sifive-unmatched/
	cp ./build/u-boot-sifive/usr/lib/u-boot/sifive_unmatched/u-boot.itb \
	$(DESTDIR)/u-boot-sifive-unmatched/
	rm -rf build

install/u-boot-starfive:
	rm -rf build
	mkdir build
	cd build && pull-lp-debs u-boot-starfive '' $(SERIES)
	cd build && dpkg -x u-boot-starfive*.deb u-boot-starfive/
	mkdir -p $(DESTDIR)/u-boot-starfive
	cp build/u-boot-starfive/usr/lib/u-boot/starfive_visionfive2/u-boot.itb \
	$(DESTDIR)/u-boot-starfive/
	cp build/u-boot-starfive/usr/lib/u-boot/starfive_visionfive2/u-boot-spl.bin.normal.out \
	$(DESTDIR)/u-boot-starfive/
	rm -rf build

install/u-boot-microchip:
	rm -rf build
	mkdir build
	cd build && pull-lp-debs u-boot-microchip '' $(SERIES)
	cd build && dpkg -x u-boot-microchip*.deb u-boot-microchip/
	mkdir -p $(DESTDIR)/u-boot-microchip
	cp build/u-boot-microchip/usr/lib/u-boot/microchip_icicle/u-boot.payload \
	$(DESTDIR)/u-boot-microchip/
	rm -rf build
