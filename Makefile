########################################
# Make script for SE lectures
#
# (c) 2014 Alexei Ostrovski
########################################

CC=xelatex
CFLAGS=--halt-on-error --interaction=batchmode
OUTDIR=out
TEMPDIR=tmp

RERUN_STR="Rerun to get cross-references right"

TEX=01/intro.tex 02/disciplines.tex 03/base-areas.tex \
	04/aux-areas.tex 05/lifecycle.tex 06/requirements.tex \
	07/modeling.tex 08/architecture.tex
AUX_FILES=$(addprefix $(OUTDIR)/,*.aux *.log *.nav *.out *.snm *.toc)

DIRS=$(subst /,,$(dir $(TEX)))
DIRS_a4=$(addsuffix -a4,$(DIRS))
DIRS_beamer=$(addsuffix -beamer,$(DIRS))

PDFS=$(addprefix $(OUTDIR)/,$(subst /,-,$(TEX:.tex=.pdf)))
PDFS_beamer=$(PDFS:.pdf=-beamer.pdf)

define DIR_template
TEX_FILE=$(filter $(1)/%,$(TEX))
TEXNAME=$$(notdir $$(TEX_FILE))
TEX_FILE_beamer=$(TEMPDIR)/$$(patsubst %.tex,%-beamer.tex,$$(notdir $$(TEX_FILE)))

$(1): $(1)-a4 $(1)-beamer
$(1)-a4: $(wildcard $(1)/fig-*.tex) $(filter $(OUTDIR)/$(1)%,$(PDFS))
$(1)-beamer: $(wildcard $(1)/fig-*.tex) $(filter $(OUTDIR)/$(1)%,$(PDFS_beamer))

$(filter $(OUTDIR)/$(1)%,$(PDFS)): $$(TEX_FILE) $(OUTDIR) $(TEMPDIR)
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) $$<
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) $$<
	mv $(TEMPDIR)/$$(patsubst %.tex,%.pdf,$$(notdir $$<)) $$@

$$(TEX_FILE_beamer): $$(TEX_FILE)
	cp $$(TEX_FILE) $(TEMPDIR)/src.tex
	sed "s/documentclass{a4beamer}/documentclass[scale=9pt]{a4beamer}/" $(TEMPDIR)/src.tex > $$@
	rm -f $(TEMPDIR)/src.tex

$(filter $(OUTDIR)/$(1)%,$(PDFS_beamer)): $$(TEX_FILE_beamer) $(OUTDIR) $(TEMPDIR)
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) $$<
	env TEXINPUTS=common:$(1): $(CC) $(CFLAGS) --output-directory $(TEMPDIR) $$<
	mv $(TEMPDIR)/$$(patsubst %.tex,%.pdf,$$(notdir $$<)) $$@
endef


$(foreach _dir,$(DIRS),$(eval $(call DIR_template,$(_dir))))

all: $(DIRS)
all-a4: $(DIRS_a4)
all-beamer: $(DIRS_beamer)

$(OUTDIR):
	mkdir $(OUTDIR)
$(TEMPDIR):
	mkdir $(TEMPDIR)

clean:
	rm -rf $(TEMPDIR)

clean-all: clean
	rm -rf $(OUTDIR)


