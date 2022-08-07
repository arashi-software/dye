PREFIX = /usr
BINDIR = out

all:
	@dart pub get
	@mkdir -p $(BINDIR)
	@dart compile exe bin/dye.dart -o $(BINDIR)/dye

install:
	@dart pub get
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@dart compile exe bin/dye.dart
	@install bin/dye.exe /usr/bin/dye

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/dye

# Dev commands
format:
	@dart format .

dev:
	@mkdir -p $(BINDIR)
	@dart compile exe bin/dye.dart -o $(BINDIR)/dye
