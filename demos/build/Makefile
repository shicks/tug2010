inputs=$(addprefix build, 1 2 3 4 5 6 7 8 9 10 11)
texs=$(addsuffix .tex, $(inputs))
pdfs=$(addsuffix .pdf, $(inputs))
stys=inlinedef.sty builddemo.sty marginfix.sty

build.pdf:$(pdfs)
	pdfjoin $^ --outfile build.pdf

$(pdfs):%.pdf:%.tex $(stys)
	pdflatex $<
