cmake_minimum_required(VERSION 2.8)

project(@project_name@)

find_package(LibR)

if(${LIBR_FOUND})
else()
  message(FATAL_ERROR "No R...")
endif()
include_directories(BEFORE ${LIBR_INCLUDE_DIRS})

if (${ENABLE_RCPP})
	execute_process(
	    COMMAND ${LIBR_EXECUTABLE} "--slave" "-e" "stopifnot(require('Rcpp'));cat(Rcpp:::Rcpp.system.file('include'))"
	    OUTPUT_VARIABLE LIBRCPP_INCLUDE_DIRS
	    ) 
	include_directories(BEFORE ${LIBRCPP_INCLUDE_DIRS})
endif()

add_custom_target(@project_name@ ALL
	COMMAND find ${CMAKE_SOURCE_DIR} -name "*.o" -exec rm "{}" "\;"
	COMMAND find ${CMAKE_SOURCE_DIR} -name "*.so" -exec rm "{}" "\;"
	COMMAND ${LIBR_EXECUTABLE} "--slave" "-e" "\"@roxygenize@\""
	COMMAND ${LIBR_EXECUTABLE} CMD INSTALL "${CMAKE_SOURCE_DIR}")
