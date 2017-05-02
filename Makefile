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

# Font family (droid or noto)
LECTURE_FONTS ?= noto+droid
# Directory where html5validator and linkchecker binaries are installed
PY_BIN ?= ~/.local/bin/

# GitHub Pages-related variables
GH_PAGES_DIR=gh-pages
GH_PAGES_FILES=$(GH_PAGES_DIR)/assets/pdf
GH_PAGES_SRC=$(GH_PAGES_DIR)/_lectures
GH_PAGES_SEC=$(GH_PAGES_DIR)/_sections
GH_PAGES_HOST ?= 127.0.0.1
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
#   $(1) - directory of the TeX file (starting from $SRCDIR)
#   $(2) - base name of the TeX file (excluding the .tex suffix)
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
	sed -r -e '/^\\input\{lecture-common\.def\}/ r common/fonts.$(LECTURE_FONTS).def' $$< > $(TEMPDIR)/$(3)-$(2).tex
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(3)-$(2) $(TEMPDIR)/$(3)-$(2).tex
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(3)-$(2) $(TEMPDIR)/$(3)-$(2).tex
	rm $(TEMPDIR)/$(3)-$(2).tex
	if [ `grep -c -e '^(Over|Under)full' $(TEMPDIR)/$(3)-$(2).log` != 0 ]; then \
		grep -C 3 -e '^(Over|Under)full' $(TEMPDIR)/$(3)-$(2).log; \
		exit 1; \
	fi
	mv $(TEMPDIR)/$$(notdir $$@) $$@

$(OUTDIR)/$(3)-$(2)-beamer.pdf: $(1)/$(2).tex $(wildcard $(1)/fig-*) $(wildcard $(1)/code-*)
	mkdir -p $(TEMPDIR)
	mkdir -p $(OUTDIR)
	sed -r -e 's/documentclass(\[.*\])?\{a4beamer\}/documentclass[page=beamer,scale=8pt]{a4beamer}/' \
	 	-e '/^\\input\{lecture-common\.def\}/ r common/fonts.$(LECTURE_FONTS).def' $$< > $(TEMPDIR)/$(3)-$(2)-beamer.tex
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(3)-$(2)-beamer $(TEMPDIR)/$(3)-$(2)-beamer.tex
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(3)-$(2)-beamer $(TEMPDIR)/$(3)-$(2)-beamer.tex
	rm $(TEMPDIR)/$(3)-$(2)-beamer.tex
	if [ `grep -c -e '^(Over|Under)full' $(TEMPDIR)/$(3)-$(2)-beamer.log` != 0 ]; then \
		grep -C 3 -e '^(Over|Under)full' $(TEMPDIR)/$(3)-$(2)-beamer.log; \
		exit 1; \
	fi
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
	mkdir -p $(TEMPDIR)
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
	rm -rf $(GH_PAGES_DIR)/_site $(GH_PAGES_DIR)/vendor

uninstall: clean clean-gh
	rm -rf $(OUTDIR) $(GH_PAGES_FILES) $(GH_PAGES_SRC) $(GH_PAGES_SEC)

########################################
# GitHub Pages-related targets
########################################

ifdef GH_PAGES_NOFILES
gh-pages: $(GH_PAGES)
	mkdir -p $(GH_PAGES_FILES)
	cp out/*-beamer.pdf $(GH_PAGES_FILES)
else
gh-pages: $(GH_PAGES) all-beamer
	mkdir -p $(GH_PAGES_FILES)
	cp out/*-beamer.pdf $(GH_PAGES_FILES)
endif

gh-build: gh-pages
	cd $(GH_PAGES_DIR) && bundle exec jekyll build

gh-serve: gh-pages
	cd $(GH_PAGES_DIR) && bundle exec jekyll serve -H $(GH_PAGES_HOST)

test-gh: test-gh-html test-gh-links

test-gh-html: gh-build
	$(PY_BIN)html5validator --root $(GH_PAGES_DIR)/_site --show-warnings

test-gh-links: gh-pages
	ps -e --format pid,command | grep 'jekyll' | grep -v 'grep' | awk '{ print $$1 }' | xargs -r kill -KILL
	cd $(GH_PAGES_DIR) && bundle exec jekyll serve 2>/dev/null 1>/dev/null &
	sleep 10
	$(PY_BIN)linkchecker -f./linkcheckerrc -o csv http://localhost:4000/ | \
		awk -F '|' -f linkchecker.awk
	ps -e --format pid,command | grep 'jekyll' | grep -v 'grep' | awk '{ print $$1 }' | xargs -r kill -KILL

gh-push-local: gh-pages
	cd $(GH_PAGES_DIR) && \
	git init && \
	echo "/_site\n.*" > .gitignore && \
	git add . && \
	git commit -m "Deploy to GitHub pages" && \
	git push --force --quiet "../.git" master:gh-pages && \
	rm -rf .git
