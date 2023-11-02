install: check
	Rscript -e "devtools::install()"

check: document
	Rscript -e "devtools::document()"

document: site
	Rscript -e "devtools::check()"

site: styler
	Rscript docs/docify.R

styler:
	Rscript -e "styler::style_pkg()"
