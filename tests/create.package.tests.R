library(RCmake)
library(methods)
a <- 1

create.R.project("test", "a", force=TRUE)
stopifnot(file.exists(normalizePath("test/CMakeLists.txt")))