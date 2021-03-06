% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plugins.R
\name{add_plugin_clean}
\alias{add_plugin_clean}
\title{Clean Plugin}
\usage{
add_plugin_clean(dry = FALSE, verbose = FALSE, clean = TRUE, protect = TRUE)
}
\arguments{
\item{dry}{Whether to simulate the removal of files.}

\item{verbose}{Write Logs to the console.}

\item{clean}{Whether to automatically remove all unused webpack assets on rebuild.}

\item{protect}{Whether to not allow removal of current webpack assets.}
}
\description{
Add the \href{https://www.npmjs.com/package/clean-webpack-plugin}{clean-webpack-plugin} to
clean the bundled files.
}
