# vim: tabstop=8 shiftwidth=8 noexpandtab

ifdef DEBUG
   ECHO = echo
endif

# extensions for files that will be used as source code
source_types := tex
source_files := $(foreach ext, $(source_types), $(wildcard *.$(ext)))

# extensions for files that will be generated
#output_types := dvi pdf ps
output_types := pdf
output_files := $(foreach ext, $(output_types), $(addsuffix .$(ext), $(basename $(source_files))))

# extensions for files that will get removed on a 'make clean'
extra_types := aux log out idx ilg ind bbl blg nav snm toc vrb lof lot
extra_files := $(foreach ext, $(extra_types), $(addsuffix .$(ext), $(basename $(source_files))))

# all graphics, listings, etc from *.tex
#DEPS = $(shell ./list_dependencies)
DEPS = $(shell find *.bib resources/logos/* figures/* listings/* -type f 2>/dev/null)

all: $(output_files)

%.pdf: %.tex $(DEPS)
	@$(ECHO) pdflatex $< </dev/null
	@$(ECHO) bibtex   $* </dev/null || :
	@$(ECHO) pdflatex $< </dev/null
	@$(ECHO) pdflatex $< </dev/null

clean:
	@$(ECHO) rm -fv $(extra_files)

realclean:
	@$(ECHO) rm -fv $(output_files) $(extra_files)
