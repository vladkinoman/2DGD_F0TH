PANDOC=pandoc
PANDOC_STANDALONE=pandoc -s
CHAPTERS_CMD=`find chapters/*.md | sort -V` metadata.yaml
PANDOC_DEFAULT_ARGS=--lua-filter ./filters/filter_helper.lua --listings -N
PDF_TEMPLATE=--pdf-engine=xelatex --template template/template.tex
EPUB_TEMPLATE=--css template/epub.css --highlight-style pygments --template template/template.xhtml
VERSION=-M version=`git describe --tags`
GLADTEX_PKG=gladtex -d "gladtex_imgs" --png -P -p "\usepackage{cancel}\usepackage{gensymb}" -

all: pseudocode python cpp epub_pseudocode epub_python epub_cpp

pseudocode:
	$(PANDOC_STANDALONE) $(PANDOC_DEFAULT_ARGS) $(CHAPTERS_CMD) $(VERSION) $(PDF_TEMPLATE) -M proglang=pseudocode -o Pseudocode_Edition.pdf

python:
	$(PANDOC_STANDALONE) $(PANDOC_DEFAULT_ARGS) $(CHAPTERS_CMD) $(VERSION) $(PDF_TEMPLATE) -M proglang=python -o Python_Edition.pdf

cpp:
	$(PANDOC_STANDALONE) $(PANDOC_DEFAULT_ARGS) $(CHAPTERS_CMD) $(VERSION) $(PDF_TEMPLATE) -M proglang=C++ -o C++_Edition.pdf

latex:
	$(PANDOC_STANDALONE) $(PANDOC_DEFAULT_ARGS) $(CHAPTERS_CMD) $(VERSION) $(PDF_TEMPLATE) -M proglang=pseudocode -o Book_LaTeX.latex

epub_pseudocode:
	$(PANDOC) $(PANDOC_DEFAULT_ARGS) template/front_matter.md $(CHAPTERS_CMD) $(VERSION) -M proglang="pseudocode" -t json | $(GLADTEX_PKG) | $(PANDOC_STANDALONE) -f json $(EPUB_TEMPLATE) --to=epub -o Pseudocode_Edition.epub

epub_python:
	$(PANDOC) $(PANDOC_DEFAULT_ARGS) template/front_matter.md $(CHAPTERS_CMD) $(VERSION) -M proglang="python" -t json | $(GLADTEX_PKG) | $(PANDOC_STANDALONE) -f json $(EPUB_TEMPLATE) --to=epub -o Pseudocode_Edition.epub

epub_cpp:
	$(PANDOC) $(PANDOC_DEFAULT_ARGS) template/front_matter.md $(CHAPTERS_CMD) $(VERSION) -M proglang="C++" -t json | $(GLADTEX_PKG) | $(PANDOC_STANDALONE) -f json $(EPUB_TEMPLATE) --to=epub -o Pseudocode_Edition.epub

.PHONY: clean
clean:
	rm -f *.pdf *.aux *.toc *.lol *.lot *.log *.out *.latex outsourced_descriptions.html gladtex_imgs/* *.epub *.mobi
	echo "Pulizia Completa"
