context("create.package.R")

test_that("Generate CMakeLists.txt correctly with R only", {
	pkg_name <- "RCmakeTestR"
	create.R.project(name=pkg_name)
	expect_true(file.exists(normalizePath(paste( pkg_name, "CMakeLists.txt", sep="/"))))
	cmakelists <- readLines(paste( pkg_name, "CMakeLists.txt", sep="/"))
	expect_true(gregexpr("@.*@", cmakelists)[[1]] == -1)
	
	unlink(paste( pkg_name, "man", sep="/"), recursive=TRUE)
})

test_that("Generate CMakeLists.txt correctly with Rcpp", {
	expect_true(require(Rcpp))
	assign("a", value=1.0, envir=.GlobalEnv)
	pkg_name <- "RCmakeTestRcpp"
	create.Rcpp.project(name=pkg_name)
	expect_true(file.exists(normalizePath(paste( pkg_name, "CMakeLists.txt", sep="/"))))
	cmakelists <- readLines(paste( pkg_name, "CMakeLists.txt", sep="/"))
	expect_true(gregexpr("@.*@", cmakelists)[[1]] == -1)
	
	unlink(paste( pkg_name, "man", sep="/"), recursive=TRUE)
})
