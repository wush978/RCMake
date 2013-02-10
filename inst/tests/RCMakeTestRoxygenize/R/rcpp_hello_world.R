#'@title Hello World of Rcpp
#'
#'@value NULL
#'
#'@export
rcpp_hello_world <- function(){
	.Call( "rcpp_hello_world", PACKAGE = "RCMakeTestRoxygenize" )
}

