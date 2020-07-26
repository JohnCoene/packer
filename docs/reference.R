library(purrr)

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
  title <- gsub("\\.Rd", "", x)
  list(title = title, link = sprintf("/references/%s", title))
})

jsonlite::toJSON(json, pretty = T, auto_unbox = T)