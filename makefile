install: check
	Rscript -e "devtools::install()"

check: document
	Rscript -e "devtools::document()"

document:
	Rscript -e "devtools::check()"
