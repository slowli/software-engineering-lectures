########################################
# Make script for SE lectures
#
# (c) 2014 Alexei Ostrovski
########################################

CC=xelatex
CFLAGS=--halt-on-error --interaction=batchmode
OUTDIR=out
TEMPDIR=tmp
SRCDIR=src

# Source TeX files, relative to SRCDIR
CATEGORIES=01-intro \
	02-development \
	03-tools \
	04-applications
TEX_intro=01/intro.tex \
	02/disciplines.tex \
	03/base-areas.tex \
	04/aux-areas.tex \
	05/lifecycle.tex
TEX_development=06/requirements.tex \
	07/modeling.tex \
	08/architecture.tex \
	09/design-patterns.tex \
	10/paradigms-1.tex \
	11/paradigms-2.tex \
	12/metaprogramming.tex \
	13/testing.tex \
	14/v-and-v.tex \
	15/evolution.tex
TEX_tools=16/configuration-1.tex \
	17/configuration-2.tex \
	18/documentation.tex \
	19/quality.tex \
	20/management.tex
TEX_applications=21/interfaces.tex \
	22/datatypes-1.tex \
	23/datatypes-2.tex \
	24/interoperability.tex \
	25/persistence.tex \
	26/services.tex \
	27/clouds.tex

GH_PAGES_DIR=gh-pages
GH_PAGES_FILES=$(GH_PAGES_DIR)/files
GH_PAGES_SRC=$(GH_PAGES_DIR)/_lectures
GH_PAGES_SEC=$(GH_PAGES_DIR)/_sections

# Function for defining rules for separate presentations.
#
# Arguments:
# 	$(1) - directory of the TeX file (starting from $SRCDIR)
# 	$(2) - base name of the TeX file (excluding the .tex suffix)
#   $(3) - number of the lecture
#   $(4) - category of the lecture
define lecture_template
$(3): $(3)-a4 $(3)-beamer
$(3)-a4: $(OUTDIR)/$(3)-$(2).pdf
$(3)-beamer: $(OUTDIR)/$(3)-$(2)-beamer.pdf

LECTURES_A4 += $(3)-a4
LECTURES_BEAMER += $(3)-beamer

$(OUTDIR)/$(3)-$(2).pdf: $(1)/$(2).tex $(wildcard $(1)/fig-*) $(wildcard $(1)/code-*)
	mkdir -p $(TEMPDIR)
	mkdir -p $(OUTDIR)
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(3)-$(2) $$<
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(3)-$(2) $$<
	mv $(TEMPDIR)/$$(notdir $$@) $$@

$(OUTDIR)/$(3)-$(2)-beamer.pdf: $(1)/$(2).tex $(wildcard $(1)/fig-*) $(wildcard $(1)/code-*)
	mkdir -p $(TEMPDIR)
	mkdir -p $(OUTDIR)
	sed -r "s/documentclass(\[.*\])?\{a4beamer\}/documentclass[page=beamer,scale=8pt]{a4beamer}/" $$< > $(TEMPDIR)/tmp.tex
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(3)-$(2)-beamer $(TEMPDIR)/tmp.tex
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(3)-$(2)-beamer $(TEMPDIR)/tmp.tex
	rm $(TEMPDIR)/tmp.tex
	mv $(TEMPDIR)/$$(notdir $$@) $$@

ifneq (,$(wildcard $(1)/README.md))

$(GH_PAGES_SRC)/$(4)/$(3)-$(2).md: $(1)/README.md
	mkdir -p $(GH_PAGES_SRC)/$(4)
	sed -r "2 i file: $(3)-$(2)-beamer.pdf" $$< > $$@

GH_PAGES += $(GH_PAGES_SRC)/$(4)/$(3)-$(2).md
endif

endef

define category_template

ifneq (,$(wildcard $(SRCDIR)/$(1)/README.md))

$(GH_PAGES_SEC)/$(1).md: $(SRCDIR)/$(1)/README.md
	mkdir -p $(GH_PAGES_SEC)
	cp $$< $$@

GH_PAGES += $(GH_PAGES_SEC)/$(1).md
endif
endef

$(foreach _cat,$(CATEGORIES), \
$(foreach _tex,$(TEX_$(word 2,$(subst -, ,$(_cat)))), \
    $(eval _num = $(patsubst %/,%,$(dir $(_tex)))) \
	$(eval _dir = $(SRCDIR)/$(_cat)/$(_num)) \
	$(eval _basename = $(basename $(notdir $(_tex)))) \
	$(eval $(call lecture_template,$(_dir),$(_basename),$(_num),$(_cat))) \
))

$(foreach _cat,$(CATEGORIES), \
	$(eval $(call category_template,$(_cat))) \
)

.PHONY: all install supplementary uninstall gh-pages

all: all-a4 all-beamer supplementary
all-a4: $(LECTURES_A4)
all-beamer: $(LECTURES_BEAMER)
install: all gh-pages

supplementary: $(OUTDIR)/questions.pdf

$(OUTDIR)/questions.pdf: supplementary/questions.tex
	mkdir -p $(TEMPDIR)
	mkdir -p $(OUTDIR)
	env TEXINPUTS=common:supplementary: $(CC) $(CFLAGS) --output-directory $(TEMPDIR) $<
	env TEXINPUTS=common:supplementary: $(CC) $(CFLAGS) --output-directory $(TEMPDIR) $<
	mv $(TEMPDIR)/$(notdir $@) $@

show-errors:
	grep -e "Overfull" -C 3 tmp/*.log

gh-pages: all-beamer $(GH_PAGES)
	mkdir -p $(GH_PAGES_FILES)
	cp out/*-beamer.pdf $(GH_PAGES_FILES)

gh-serve: gh-pages
	cd $(GH_PAGES_DIR) && bundle exec jekyll serve

clean:
	rm -rf $(TEMPDIR)

uninstall: clean
	rm -rf $(OUTDIR)
	rm -rf $(GH_PAGES_FILES) $(GH_PAGES_SRC)

