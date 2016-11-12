#!/bin/bash
TEXFILES=$(find . -name "*.tex" -type f)
for TEXFILE in $TEXFILES
do
  TEXDIR=$(dirname $TEXFILE)
  TEXBASENAME=$(basename $TEXFILE)
  NAME="${TEXBASENAME%.*}"
  HTMLNAME=$TEXDIR/$NAME.html
  pandoc $TEXFILE -f latex -t html5 -H header -N --toc --mathjax -o $HTMLNAME
done
