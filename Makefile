SHELL=/bin/bash -o pipefail

SPHINXOPTS    =
SPHINXBUILD   = ./bin/sphinx-build
PAPER         =
BUILDDIR      = $(CURDIR)/_build

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

all: compile

compile: _build/.buildinfo

bin/pip:
	python3 -m venv .

requirements.txt:
	touch requirements.txt

lib/.requirements: requirements.txt requirements-to-freeze.txt bin/pip
	# Install frozen requirements
	./bin/pip install -r requirements.txt
	# Make sure any new requirements are available
	./bin/pip install -r requirements-to-freeze.txt
	# Freeze the output at current state
	./bin/pip freeze | grep -v 'pkg-resources==0.0.0' > requirements.txt
	touch lib/.requirements

_build/.buildinfo: lib/.requirements *.rst
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex

pdf: _build/.buildinfo
	(cd $(BUILDDIR)/latex && make)

.PHONY: compile test lint coverage start install _build/.buildinfo
