PANDOC ?= pandoc

MANSECTION ?= 1

PANDOC_OPTIONS=-f gfm+definition_lists --standalone


MANPAGE.md = $(PANDOC) --standalone $(PANDOC_OPTIONS) --to man

%.$(MANSECTION): %.$(MANSECTION).md
	$(MANPAGE.md) $< -o $@