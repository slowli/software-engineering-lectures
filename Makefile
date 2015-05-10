########################################
# Make script for SE lectures
#
# (c) 2014 Alexei Ostrovski
########################################

CC=xelatex
CFLAGS=--halt-on-error --interaction=batchmode
OUTDIR=out
TEMPDIR=tmp

# Source TeX files
TEX=01/intro.tex 02/disciplines.tex 03/base-areas.tex \
	04/aux-areas.tex 05/lifecycle.tex 06/requirements.tex \
	07/modeling.tex 08/architecture.tex 09/design-patterns.tex \
	10/paradigms-1.tex 11/paradigms-2.tex 12/metaprogramming.tex \
	13/testing.tex 14/v-and-v.tex 15/evolution.tex \
	16/documentation.tex 17/interfaces.tex \
	18/datatypes-1.tex 19/datatypes-2.tex 20/interoperability.tex \
	21/configuration-1.tex 22/configuration-2.tex 23/quality.tex \
	24/management.tex 25/persistence.tex

DIRS=$(subst /,,$(dir $(TEX)))
DIRS_a4=$(addsuffix -a4,$(DIRS))
DIRS_beamer=$(addsuffix -beamer,$(DIRS))

# Function for defining rules for separate presentations.
#
# Arguments:
# 	$(1) - directory of the TeX file
# 	$(2) - base name of the TeX file (excluding the .tex suffix)
define DIR_template
$(1): $(1)-a4 $(1)-beamer
$(1)-a4: $(OUTDIR)/$(1)-$(2).pdf
$(1)-beamer: $(OUTDIR)/$(1)-$(2)-beamer.pdf

$(OUTDIR)/$(1)-$(2).pdf: $(1)/$(2).tex $(wildcard $(1)/fig-*) $(wildcard $(1)/code-*)
	mkdir -p $(TEMPDIR)
	mkdir -p $(OUTDIR)
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(1)-$(2) $$<
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(1)-$(2) $$<
	mv $(TEMPDIR)/$$(notdir $$@) $$@

$(OUTDIR)/$(1)-$(2)-beamer.pdf: $(1)/$(2).tex $(wildcard $(1)/fig-*) $(wildcard $(1)/code-*)
	mkdir -p $(TEMPDIR)
	mkdir -p $(OUTDIR)
	sed -r "s/documentclass(\[.*\])?\{a4beamer\}/documentclass[page=beamer,scale=8pt]{a4beamer}/" $$< > $(TEMPDIR)/tmp.tex
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(1)-$(2)-beamer $(TEMPDIR)/tmp.tex
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) --jobname=$(1)-$(2)-beamer $(TEMPDIR)/tmp.tex
	rm $(TEMPDIR)/tmp.tex
	mv $(TEMPDIR)/$$(notdir $$@) $$@
endef

all: $(DIRS)
all-a4: $(DIRS_a4)
all-beamer: $(DIRS_beamer)
install: all

$(foreach _dir,$(DIRS), \
	$(eval _basename = $(basename $(notdir $(filter $(_dir)/%,$(TEX))))) \
	$(eval $(call DIR_template,$(_dir),$(_basename))) \
)

show-errors:
	grep -e "Overfull" -C 3 tmp/*.log

clean:
	rm -rf $(TEMPDIR)

uninstall: clean
	rm -rf $(OUTDIR)

