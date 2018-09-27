TEXS := $(wildcard *.tex)
BIBS := $(wildcard *.bib)
BIB_GEN := $(BIBS:.bib=.bib.gen)

LATEX  := xelatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error
BIBER  := biber
TITLE  := main

DIR_NAME := $(shell basename "`pwd`")

SUBDIRS := $(dir $(wildcard */.))
OUTPUT  := output

all: $(OUTPUT) $(SUBDIRS)

$(OUTPUT):
	mkdir -p $@

$(SUBDIRS):
	cp Makefile $@/
	$(MAKE) -C $@ pdf
	rm -rf $@/Makefile

pdf: $(TEXS) $(BIB_GEN)
	$(LATEX) $(TITLE)
	$(LATEX) $(TITLE)
	cp $(TITLE).pdf ../output/$(DIR_NAME).pdf

%.bib.gen: %.bib
	touch $@
	$(LATEX) $(TITLE)
	$(BIBER) $(TITLE)

clean:
	for dir in $(SUBDIRS) ; do \
		cd $$dir; \
		rm -rf *.gen *.pdf *.bbl *.blg *.log *.bcf *.aux *.xml *.out _minted-* *.gz Makefile; \
		cd ..; \
	done
	
	rm -rf output/

.PHONY: all, $(SUBDIRS)