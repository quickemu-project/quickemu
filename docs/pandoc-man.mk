PANDOC ?= pandoc

MANSECTION ?= 1

MANPAGE.md = $(PANDOC) --standalone $(PANDOCFLAGS) --to man

%.$(MANSECTION): %.$(MANSECTION).md
	$(MANPAGE.md) $< -o $@