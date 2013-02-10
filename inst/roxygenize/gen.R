template <- readLines("_.R")
for(i in 1:3) {
	sapply(combn(c('rd', 'collate', 'namespace'), i, simplify=FALSE), function(a) {
		out.content <- template
		roclets.src <- capture.output(dump("a", file=""), file=NULL)[2]
		out.content <- gsub("@roclets@", roclets.src, out.content, fixed=TRUE)
		out.file <- sprintf("_%s.R", paste(sort(a), collapse=""))
		write(out.content, file=out.file)
		})
}
