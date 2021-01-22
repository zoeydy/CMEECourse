#!/bin/bash


pdflatex ZongyiHu_MiniProject.tex
pdflatex ZongyiHu_MiniProject.tex
name=$(echo "ZongyiHu_MiniProject.tex" | cut -f 1 -d '.')
bibtex $name
echo "$name"
pdflatex ZongyiHu_MiniProject.tex
pdflatex ZongyiHu_MiniProject.tex
evince $name.pdf 

##Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.bbl
rm *.blg
rm *.fdb_latexmk
rm *.fls