#'@export
list.IDE <- function(is_tolower = TRUE) {
	result <- system("cmake --help", intern=TRUE)
	start.index <- grep("The following generators are available on this platform:", result, fixed=TRUE) + 1
	end.index <- length(result)
	result <- paste(result[start.index:end.index], collapse="")
	result <- strsplit(result, split=".", fixed=TRUE)[[1]]
	builder.index <- grep("=", result, fixed=TRUE)
	stopifnot(1 %in% builder.index)
	result[setdiff(1:length(result), builder.index) - 1] <- paste(result[setdiff(1:length(result), builder.index) - 1], result[setdiff(1:length(result), builder.index)], sep="")
	result <- result[builder.index]
	result <- sapply(strsplit(result, "="), function(x) x[1])
	if (is_tolower)
		return(tolower(str_trim(result)))
	else
		return(str_trim(result))
}

#'@export
get.IDE <- function(ide) {
	if (length(ide) > 1) {
		warnings("only the first element of \"ide\" will be used")
		ide <- ide[1]
	}
	result <- list.IDE(FALSE)
	if (class(ide) == "integer") {
		return(result[ide])
	}
	ide <- tolower(ide)
	result.tolower <- tolower(result)
	result.index <- pmatch(ide, result.tolower)
	if (is.na(result.index)) {
		stop("No IDE is selected")
	}
	return(result[result.index])
}

#'@export 
execute.cmake <- function(cmakelists.path, IDE = 1L, argv = "") {
	IDE <- get.IDE(IDE)
	system(sprintf("cmake %s -DLibR_DIR=%s -G \"%s\" %s", 
								 cmakelists.path, 
								 system.file("", package="RCmake"), 
								 IDE,
								 argv))
}