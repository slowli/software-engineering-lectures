########################################
# Make script for SE lectures
#
# (c) 2014, 2017 Alex Ostrovski
########################################

########################################
# Variables
########################################
CC=xelatex
CFLAGS=--halt-on-error --interaction=batchmode
OUTDIR=out
TEMPDIR=tmp
SRCDIR=src

CATEGORIES=$(shell ls $(SRCDIR))

# GitHub Pages-related variables
GH_PAGES_DIR=gh-pages
GH_PAGES_FILES=$(GH_PAGES_DIR)/assets/pdf
GH_PAGES_SRC=$(GH_PAGES_DIR)/_lectures
GH_PAGES_SEC=$(GH_PAGES_DIR)/_sections
# Optional excerpt separator
EXCERPT_SEP=<!--more-->
# Heading used to locate the topic list within a page
TOPICS_HEAD=Темы для самостоятельной работы
# Heading used to locate the question list within a page
QUESTIONS_HEAD=Контрольные вопросы

########################################
# Functions
########################################

# Function for defining rules for separate presentations.
#
# Arguments:
# 	$(1) - directory of the TeX file (starting from $SRCDIR)
# 	$(2) - base name of the TeX file (excluding the .tex suffix)
#   $(3) - number of the lecture
#   $(4) - section of the lecture
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
	sed -r -e '1 s/^#+ (.*)$$$$/---\ntitle: "\1"\n---/' $$< | \
	sed -r -e "2 i file: $(3)-$(2)-beamer.pdf" \
		-e "2 i section_id: $(4)" \
		-e "2 i index: $(3)" | \
	sed -r -e "3 s/^section_id: .*-/section_id: /" \
		-e "4 s/^index: 0*([1-9][0-9]*).*/index: \1/" > $$@
	if [ `grep -c -e '$(EXCERPT_SEP)' $$<` != 0 ]; then \
		sed -i -e '2 i excerpt_separator: $(EXCERPT_SEP)' $$@; \
	fi

GH_PAGES += $(GH_PAGES_SRC)/$(4)/$(3)-$(2).md
endif

endef

# Function for defining rules for sections of lectures.
# Prepares the Jekyll-ready version of the README for the section,
# including the front matter, with topics and questions lists extracted
# from the main text with the help of sed magic
#
# Arguments:
#  $(1) - section name
define category_template

ifneq (,$(wildcard $(SRCDIR)/$(1)/README.md))

$(GH_PAGES_SEC)/$(1).md: $(SRCDIR)/$(1)/README.md
	mkdir -p $(GH_PAGES_SEC)
	sed -r -e '1 s/^#+ (.*)$$$$/---\ntitle: "\1"\n---/' $$< | \
	sed -r -e "2 i section_id: $(1)" \
		-e "2 i index: $(1)" | \
	sed -r -e "2 s/section_id: .*-/section_id: /" \
		-e "3 s/index: 0*([1-9][0-9]*).*/index: \1/" > $$@
	if [ `grep -c -e '$(EXCERPT_SEP)' $$<` != 0 ]; then \
		sed -i -e '2 i excerpt_separator: $(EXCERPT_SEP)' $$@; \
	fi
	sed -r -n -e "1 i topics:" \
		-e '/^#+ $(TOPICS_HEAD)/,/^#+/{ /(^#+)|(^[[:space:]]*$$$$)/!{ s/[[:space:]]+\*[[:space:]]*(.*)$$$$/  - "\1"/; p; } }' \
		$$@ > $(TEMPDIR)/section.yml
	sed -r -n -e "1 i questions:" \
		-e '/^#+ $(QUESTIONS_HEAD)/,/^#+/{ /(^#+)|(^[[:space:]]*$$$$)/!{ s/[[:space:]]+\*[[:space:]]*(.*)$$$$/  - "\1"/; p; } }' \
		$$@ >> $(TEMPDIR)/section.yml
	sed -i -e '2 r $(TEMPDIR)/section.yml' $$@

GH_PAGES += $(GH_PAGES_SEC)/$(1).md
endif
endef

########################################
# Functions execution
########################################

$(foreach _cat,$(CATEGORIES), \
$(foreach _tex,$(shell ls -1 $(SRCDIR)/$(_cat)/*/*.tex | grep -v "\/fig-" | sed -e "s|^[^/]*/[^/]*/||"), \
  $(eval _num = $(patsubst %/,%,$(dir $(_tex)))) \
	$(eval _dir = $(SRCDIR)/$(_cat)/$(_num)) \
	$(eval _basename = $(basename $(notdir $(_tex)))) \
	$(eval $(call lecture_template,$(_dir),$(_basename),$(_num),$(_cat))) \
))

$(foreach _cat,$(CATEGORIES), \
	$(eval $(call category_template,$(_cat))) \
)

########################################
# Main targets
########################################

.PHONY: all install supplementary uninstall gh-pages
.DEFAULT_GOAL := all

all: all-a4 all-beamer supplementary
all-a4: $(LECTURES_A4)
all-beamer: $(LECTURES_BEAMER)
install: all gh-pages

clean:
	rm -rf $(TEMPDIR)

clean-gh:
	rm -rf $(GH_PAGES_FILES) $(GH_PAGES_SRC) $(GH_PAGES_SEC) $(GH_PAGES_DIR)/_site

uninstall: clean clean-gh
	rm -rf $(OUTDIR)

show-errors:
	grep -e "Overfull" -C 3 tmp/*.log

########################################
# GitHub Pages-related targets
########################################

ifdef GH_PAGES_NOFILES
gh-pages: $(GH_PAGES)
else
gh-pages: all-beamer $(GH_PAGES)
	mkdir -p $(GH_PAGES_FILES)
	cp out/*-beamer.pdf $(GH_PAGES_FILES)
endif

gh-serve: gh-pages
	cd $(GH_PAGES_DIR) && bundle exec jekyll serve

gh-push-local: gh-pages
	cd $(GH_PAGES_DIR) && \
	git init && \
	mv .gitignore .gitignore~ && \
	echo "/_site\n.*" > .gitignore && \
	git add . && \
	git commit -m "Deploy to GitHub pages" && \
	git push --force --quiet "../.git" master:gh-pages && \
	rm -rf .git && \
	mv -f .gitignore~ .gitignore
