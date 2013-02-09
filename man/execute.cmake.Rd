\name{execute.cmake}
\alias{execute.cmake}
\title{Execute \code{cmake}}
\usage{
  execute.cmake(cmakelists.path, IDE = 1L, argv = "")
}
\arguments{
  \item{cmakelists.path}{Location of \code{CMakeLists.txt}}

  \item{IDE}{Integer or character. Integer indicates that
  the IDE-th element of \code{list.IDE()} will be
  generated. Character will use \code{pmatch} to find the
  IDE in \code{list.IDE()}.}

  \item{argv}{Additional arguments passed to \code{CMake}}
}
\description{
  Execute \code{cmake}
}

