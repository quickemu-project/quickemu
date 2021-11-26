include pandoc-man.mk

ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

datarootdir := $(PREFIX)/share
datadir := $(datarootdir)
mandir := $(datarootdir)/man
bindir := $(datarootdir)/bin


all: quickget.1 quickemu.1 quickemu_conf.1

clean:
	rm *.1

install: all
	install -d $(DESTDIR)$(mandir)/man1
	install -d $(DESTDIR)$(bindir)
	#install -m 644 quickget.1 quickemu.1 quickemu_conf.1 $(DESTDIR)$(mandir)/man1
	install -m 644 quickget.1 $(DESTDIR)$(mandir)/man1
	install -m 644 quickemu.1 $(DESTDIR)$(mandir)/man1
	install -m 644 quickemu_conf.1 $(DESTDIR)$(mandir)/man1
	#install -m 644 quickgui.1 $(DESTDIR)$(mandir)/man1


uninstall::
	rm -f $(DESTDIR)$(mandir)/man1/quickget.1
	rm -f $(DESTDIR)$(mandir)/man1/quickemu.1
	rm -f $(DESTDIR)$(mandir)/man1/quickemu_conf.1

#clean::

#quickgui.1

.PHONY: all