#!/bin/bash

# Very simple script to download PDF manuals for the latest versions of R packages.

set -eEu

rmanualsDir="${HOME}/Downloads/rmanuals"
if ! cd "$rmanualsDir" >& /dev/null
then
	mkdir -v "$rmanualsDir"
	cd "$rmanualsDir"
fi

if [[ -f *.pdf ]]
then
	pkgList="$(echo data.table ggplot2 openxlsx readxl rstan statnet dagitty *.pdf "$@" | tr ' ' '\n' | sed 's:.pdf$::' | sort | uniq)"
else
	pkgList="$(echo data.table ggplot2 openxlsx readxl rstan statnet dagitty "$@" | tr ' ' '\n' | sed 's:.pdf$::' | sort | uniq)"
fi

echo Downloading "$pkgList" | tr '\n' ' '
echo

for pkgname in $pkgList
do
	filename="${pkgname}.pdf"
	echo "$filename"
	curl --output "$filename" --progress-bar "https://cran.r-project.org/web/packages/${pkgname}/$filename"
done

curl --output "RMarkdownDefinitiveGuide.pdf" --progress-bar "https://bookdown.org/yihui/rmarkdown/rmarkdown.pdf"
