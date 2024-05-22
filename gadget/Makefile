
SERIES ?= ocular
DESTDIR ?= install

all:
	make install/u-boot-sifive-unmatched
	make install/u-boot-starfive
	make meta

meta:
	mkdir -p $(DESTDIR)/meta
	cp gadget-riscv64.yaml $(DESTDIR)/meta/gadget.yaml

install/u-boot-sifive-unmatched:
	mkdir -p build
	rm -rf build/u-boot-sifive*
	cd build && pull-lp-debs u-boot-sifive '' $(SERIES)
	cd build && dpkg -x u-boot-sifive*.deb u-boot-sifive/
	mkdir -p $(DESTDIR)/u-boot-sifive-unmatched
	cp ./build/u-boot-sifive/usr/lib/u-boot/sifive_unmatched/u-boot-spl.bin \
	$(DESTDIR)/u-boot-sifive-unmatched/
	cp ./build/u-boot-sifive/usr/lib/u-boot/sifive_unmatched/u-boot.itb \
	$(DESTDIR)/u-boot-sifive-unmatched/
	rm -rf build/u-boot-sifive*

install/u-boot-starfive:
	mkdir -p build
	rm -rf build/u-boot-starfive*
	cd build && pull-lp-debs u-boot-starfive '' $(SERIES)
	cd build && dpkg -x u-boot-starfive*.deb u-boot-starfive/
	mkdir -p $(DESTDIR)/u-boot-starfive
	cp build/u-boot-starfive/usr/lib/u-boot/starfive_visionfive2/u-boot.itb \
	$(DESTDIR)/u-boot-starfive/
	cp build/u-boot-starfive/usr/lib/u-boot/starfive_visionfive2/u-boot-spl.bin.normal.out \
	$(DESTDIR)/u-boot-starfive/
	rm -rf build/u-boot-starfive*
