#!/bin/bash
TEXFILES=$(find . -name "*.tex" -type f)
for TEXFILE in $TEXFILES
do
  TEXDIR=$(dirname $TEXFILE)
  TEXBASENAME=$(basename $TEXFILE)
  NAME="${TEXBASENAME%.*}"
  HTMLNAME=$TEXDIR/$NAME.html
  if [ $NAME == "index" ]; then
    pandoc $TEXFILE -f latex -t html5 -s -o $HTMLNAME
  elif [ $NAME == "document" ]; then
    pandoc $TEXFILE -f latex -t html5 -H header -N --toc --mathjax -o $HTMLNAME
  fi
done
