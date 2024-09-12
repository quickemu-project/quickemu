PANDOC ?= pandoc
PANDOC_OPTIONS = -f gfm+definition_lists

.SUFFIXES: .1.md .1

.1.md.1:
	$(PANDOC) --standalone $(PANDOC_OPTIONS) --to man -o $@ $<
