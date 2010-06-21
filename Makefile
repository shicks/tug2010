pages=margins-bad #margins-bad-expected
pageseps=$(addsuffix .dvi,$(pages))
pageseps=$(addsuffix .eps,$(pages))

$(pagesdvi):%.dvi:%.tex
	latex $< 

$(pageseps):%.eps:%.dvi
	dvips -E -o - $< | \
	    sed -e 's/BoundingBox:.*/BoundingBox: 0 0 612 792/' > $@

slides.1:slides.tex $(pageseps)
	latex slides.tex

slides.dvi:slides.1
	latex slides.tex

slides.ps:slides.dvi
	dvips -o$@ $<

slides.pdf:slides.ps
	ps2pdf $< $@
