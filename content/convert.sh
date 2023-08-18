#!/bin/sh

dirname=$(dirname $1)
file=$(basename $1 .adoc)
asciidoctor -b docbook --attribute leveloffset=+1 --out-file - $dirname/$file.adoc  | pandoc --wrap=preserve -t gfm -f docbook -o $dirname/$file.md
./fix.sh $dirname/$file.md
