pages=margins-bad margins-bad-expected
pagesdvi=$(addsuffix .dvi,$(pages))
pageseps=$(addsuffix .eps,$(pages))
svgfigs=example1.eps example2.eps example3.eps example4.eps example5.eps

.PHONY:all clean

all: slides.pdf
clean:
	rm -f *.aux *.log *.dvi *.ps *.out *.toc *.nav *.eps *.snm *.vrb *~

$(svgfigs):%.eps:%.svg
	inkscape -C -E $@ $< 2>/dev/null || true

$(pagesdvi):%.dvi:%.tex
	latex $<

$(pageseps):%.eps:%.dvi
	dvips -E -o - $< | \
	    sed -e 's/BoundingBox:.*/BoundingBox: 0 0 612 792/' > $@

slides.1:slides.tex $(pageseps) $(svgfigs)
	latex slides.tex

slides.dvi:slides.1
	latex slides.tex

slides.ps:slides.dvi
	dvips -o$@ $<

slides.pdf:slides.ps
	ps2pdf $< $@

inlinedef.sty:inlinedef.ins inlinedef.dtx
	latex inlinedef.ins
