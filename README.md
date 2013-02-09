# Introduction

Rstudio is great IDE for R, but it lacks some useful features for developing C/C++
such as source nevigation and type hierarchy. There are various type of
IDE for C/C++ such as CodeBlocks and Eclipse CDT, but it is complicated to setup 
an appropriate projects 

[CMake](http://www.cmake.org/) is a _cross platform_ and _open-source_ build system which
can generate projects of various IDE. However, the user still needs to learn the
_CMake script_ for setting up projects.

Therefore, I decide to develop `RCMake` which provides basic commands to setup
C/C++ projects for cmake supported IDEs.

# Install

```r
library(devtools)
install_github("RCMake", "wush978")
```

# Usage

## Step 1: Generate IDE project

R project:

```r
library(RCMake)
setwd(tempdir())
a <- 1
package.skeleton("RCMakeDemoR", "a")
create.R.project(name="RCMakeDemoR", path=".") # CMakeLists.txt will be put at <path>/<name>. I suggest to put it in the root of R package
list.IDE() # check available IDE
dir.create("build") # It is recommended to make a seperated directory to build project 
setwd("build")
execute.cmake(cmakelists.path="../RCMakeDemoR", IDE="eclipse") # generate eclipse CDT project at "build"
```

Rcpp project:

```r
library(RCMake)
library(Rcpp)
setwd(tempdir())
Rcpp.package.skeleton("RCMakeDemoRcpp")
create.Rcpp.project(name="RCMakeDemoRcpp", path=".") # CMakeLists.txt will be put at <path>/<name>. I suggest to put it in the root of R package
list.IDE() # check available IDE
dir.create("build") # It is recommended to make a seperated directory to build project 
setwd("build")
execute.cmake(cmakelists.path="../RCMakeDemoRcpp", IDE="eclipse") # generate eclipse CDT project at "build"
```

## Step 2, import generated project

### KDevelop3

It creates in the toplevel binary directory files:
- Project.kdevelop
- Project.kdevelop.filelist

### Eclipse CDT

Open eclipse and import project from `build`(See [cmake-eclipse-cdt](http://www.vtk.org/Wiki/Eclipse_CDT4_Generator) for demo). 

### Code::Blocks

CMake: _This support is still in beta and needs feedback in order to mature._

# Reference

- [CMake Generator Specific Information](http://www.cmake.org/Wiki/CMake_Generator_Specific_Information)