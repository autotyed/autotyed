all:
	@echo Usage: make install

install:
	scripts/install.sh

macos: mac

mac:
	scripts/install_mac.sh

linux:
	scripts/install_linux.sh
