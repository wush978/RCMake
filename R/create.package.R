get_cmakelists <- function() {
	cmakelists.path <- normalizePath(paste(system.file(package=.packageName), 'CMakeLists.txt', sep='/'))
	return(readLines(cmakelists.path))
}

set_cmakelists <- function(cmakelists, key, value) {
	cmakelists <- gsub(sprintf("@%s@", key), value, cmakelists, fixed=TRUE)
	return(cmakelists)
}

#'@export
create.R.project <- function (
	name = "anRpackage", 
	list = character(), 
	environment = .GlobalEnv, 
	path = ".", 
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
	cmakelists <- get_cmakelists()
	cmakelists <- set_cmakelists(cmakelists, "project_name", name) 
	write(cmakelists, file=normalizePath(paste(pkg.root, 'CMakeLists.txt', sep='/'), mustWork=FALSE))
}

