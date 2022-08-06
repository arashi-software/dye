PREFIX = /usr
BINDIR = out

all:
	@mkdir -p $(BINDIR)
	@dart compile exe bin/dye.dart
	@cp -rvf bin/dye.exe $(BINDIR)/dye

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@dart compile exe bin/dye.dart
	@sudo install bin/dye.exe /usr/bin/dye

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/dye

# Dev commands
format:
	@dart format .
