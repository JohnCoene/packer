library(purrr)

fs::file_copy("NEWS.md", "docs/NEWS.md", overwrite = TRUE)

fs::dir_delete("./docs/references")
fs::dir_create("./docs/references")

# ------------------------------------------- REFERENCE
# functions
get_id <- function(x){
  gsub("\\.md", "", x)
}

get_name <- function(x){
  x <- gsub("\\_", " ", x)
  gsub("\\.md", "", x)
}

# directory of .Rd
dir <- "./man"

# read .Rd
files <- list.files(dir)
files <- files[grepl("\\.Rd", files)]

docs <- purrr::map(files, function(x){
  input <- paste0(dir, "/", x)
  nm <- gsub("\\.Rd", ".md", x)
  output <- paste0("./docs/references/", nm)
  Rd2md::Rd2markdown(input, output)

  list(name = nm, output = output)
})

json <- purrr::map(files, function(x){
  link <- gsub("\\.Rd", "", x)
  title <- tools::toTitleCase(link)
  title <- gsub("_", " ", title)
  list(title = title, link = sprintf("/references/%s", link))
})

json <- jsonlite::toJSON(json, pretty = FALSE, auto_unbox = TRUE)

cat(json, "\n")
