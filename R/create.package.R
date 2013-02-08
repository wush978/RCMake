get_cmakelists <- function() {
	cmakelists.path <- normalizePath(paste(system.file(package=.packageName), 'CMakeLists.txt', sep='/'))
	cmakelists <- readLines(cmakelists.path)
	return(cmakelists)
}

set_cmakelists <- function(cmakelists, key, value) {
	if (is.null(value)) value <- ""
	cmakelists <- gsub(sprintf("@%s@", key), paste(value, collapse=" "), cmakelists, fixed=TRUE)
	return(cmakelists)
}

set_cmakelists_include <- function(cmakelists, includes_directory) {
	if (length(includes_directory) == 0) {
		cmakelists <- set_cmakelists(cmakelists, "includes_directory", "")
		return(cmakelists)
	}
	cmake_include_command_template <- "include_directories(BEFORE \"%s\")"
	cmakelists <- set_cmakelists(cmakelists, "includes_directory", paste(
		sapply(
			includes_directory, 
			function(s) sprintf(cmake_include_command_template, s)), 
		collapse="\n"))
	return(cmakelists)
}

get_roxygenize <- function(is_roxygenize, roclets) {
	if (is_roxygenize == FALSE) {
		return("NULL")
	}
	roclets <- capture.output(dump("roclets", file=""), file=NULL)[2]
	roclets <- gsub("\"", "'", roclets, fixed=TRUE)
	return(sprintf("stopifnot(require(roxygen2));roxygenize('${CMAKE_SOURCE_DIR}',roclets=%s)", roclets))
}

#'@export
create.R.project <- function (
	name = "anRpackage", 
	path = ".", 
	is_roxygenize = FALSE,
	roclets = c("collate", "namespace", "rd"),
	includes_directory = c())
{
	pkg.root <- paste(path, name, sep='/')
	cat("Generating CMakeLists.txt...\n")
	cmakelists <- get_cmakelists()
	cmakelists <- set_cmakelists(cmakelists, "project_name", name) 
	cmakelists <- set_cmakelists(cmakelists, "roxygenize", get_roxygenize(is_roxygenize, roclets))
	cmakelists <- set_cmakelists_include(cmakelists, includes_directory)
	write(cmakelists, file=normalizePath(paste(pkg.root, 'CMakeLists.txt', sep='/'), mustWork=FALSE))
}

#'@export
create.Rcpp.project <- function(
	name = "anRpackage", 
	path = ".", 
	is_roxygenize = FALSE,
	roclets = c("collate", "namespace", "rd"),
	includes_directory = system.file("include", package="Rcpp")) 
{
	create.R.project(
		name=name,
		path=path,
		is_roxygenize=is_roxygenize,
		roclets=roclets,
		includes_directory=includes_directory)
}
