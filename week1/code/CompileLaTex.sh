#!/bin/bash

pdflatex $1
pdflatex $1
name=$(echo "$1" | cut -f 1 -d '.')
bibtex $name
echo "$name"
pdflatex $1
pdflatex $1
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