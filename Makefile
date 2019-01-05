TEXS := $(wildcard *.tex)

LATEXMK := latexmk -shell-escape -pdfxe
TITLE   := main

DIR_NAME := $(shell basename "`pwd`")
MAKEFILE_PATH := $(shell readlink -f Makefile)

SUBDIRS := $(dir $(wildcard */.))

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -f "$(MAKEFILE_PATH)" -C $@ pdf

pdf: $(TEXS)
	$(LATEXMK) $(TITLE).tex
	cp $(TITLE).pdf ../$(DIR_NAME).pdf

clean:
	for dir in $(SUBDIRS) ; do \
		cd $$dir; \
		rm -rf *.gen *.pdf *.bbl *.blg *.log *.bcf *.aux *.xml *.out _minted-* *.gz; \
		cd ..; \
	done

.PHONY: all, $(SUBDIRS)