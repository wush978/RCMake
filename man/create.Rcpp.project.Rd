\name{create.Rcpp.project}
\alias{create.Rcpp.project}
\title{Create CMake script for R extension with Rcpp}
\usage{
  create.Rcpp.project(name = "anRpackage", path = ".",
    is_roxygenize = FALSE,
    roclets = c("collate", "namespace", "rd"),
    includes_directory = c())
}
\arguments{
  \item{name}{name of project}

  \item{path}{the \code{CMakeLists.txt} will be created at
  \code{path}/\code{name}}

  \item{is_roxygenize}{If call R to execute
  \code{roxygenize} before building or not}

  \item{roclets}{A parameter which will be passed to
  \code{roxygenize}. Please see \code{\link{roxygenize}}}

  \item{includes_directory}{Additional include directories}
}
\description{
  Create CMake script with: - add ${R_HOME}/include into
  include directories - add ${R_CPP_ROOT}/include into
  include directories - add \code{R CMD INSTALL} as build
  tools
}
\seealso{
  \code{\link{create.R.project}}
}

