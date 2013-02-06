get_cmakelists <- function() {
	cmakelists.path <- normalizePath(paste(system.file(package=.packageName), 'CMakeLists.txt', sep='/'))
	return(readLines(cmakelists.path))
}

set_cmakelists <- function(cmakelists, key, value) {
	if (is.null(value)) value <- ""
	cmakelists <- gsub(sprintf("@%s@", key), value, cmakelists, fixed=TRUE)
	return(cmakelists)
}

get_roxygenize <- function(is_roxygenize, roclets) {
	if (is_roxygenize == FALSE) {
		return(NULL)
	}
	roclets <- capture.output(dump("roclets", file=""), file=NULL)[2]
	roclets <- gsub("\"", "'", roclets, fixed=TRUE)
	return(sprintf("stopifnot(require(roxygen2));roxygenize('${CMAKE_SOURCE_DIR}',roclets=%s)", roclets))
}

#'@export
create.R.project <- function (
	name = "anRpackage", 
	list = character(), 
	path = ".", 
	is_rcpp = FALSE,
	is_roxygenize = FALSE,
	roclets = c("collate", "namespace", "rd"),
	environment = .GlobalEnv, 
	force = FALSE, 
  namespace = TRUE, code_files = character()) 
{
	eval(package.skeleton(
		name=name, list=list, 
		environment=environment, 
		path=path, 
		force=force, 
		namespace=namespace, 
		code_files=code_files), envir = .GlobalEnv)
	pkg.root <- paste(path, name, sep='/')
	cat("Generating CMakeLists.txt...\n")
	cmakelists <- get_cmakelists()
	cmakelists <- set_cmakelists(cmakelists, "project_name", name) 
	cmakelists <- set_cmakelists(cmakelists, "roxygenize", get_roxygenize(is_roxygenize, roclets))
	write(cmakelists, file=normalizePath(paste(pkg.root, 'CMakeLists.txt', sep='/'), mustWork=FALSE))
}

