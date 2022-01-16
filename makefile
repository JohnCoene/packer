install: check
	Rscript -e "devtools::install()"

check: document
	Rscript -e "devtools::document()"

document: site
	Rscript -e "devtools::check()"

site:
	Rscript docs/docify.R
