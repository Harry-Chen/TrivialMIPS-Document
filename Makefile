TEXS := $(wildcard *.tex)
BIBS := $(wildcard *.bib)
BIB_GEN := $(BIBS:.bib=.bib.gen)

LATEX  := xelatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error
BIBER  := biber
TITLE  := main

DIR_NAME := $(shell basename "`pwd`")
MAKEFILE_PATH := $(shell readlink -f Makefile)

SUBDIRS := $(dir $(wildcard */.))

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -f "$(MAKEFILE_PATH)" -C $@ pdf

pdf: $(TEXS) $(BIB_GEN)
	$(LATEX) $(TITLE)
	$(LATEX) $(TITLE)
	cp $(TITLE).pdf ../$(DIR_NAME).pdf

%.bib.gen: %.bib
	touch $@
	$(LATEX) $(TITLE)
	$(BIBER) $(TITLE)

clean:
	for dir in $(SUBDIRS) ; do \
		cd $$dir; \
		rm -rf *.gen *.pdf *.bbl *.blg *.log *.bcf *.aux *.xml *.out _minted-* *.gz; \
		cd ..; \
	done

.PHONY: all, $(SUBDIRS)