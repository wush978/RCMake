cmake_minimum_required(VERSION 2.8)

project(@project_name@)

find_package(LibR)

if(${LIBR_FOUND})
else()
  message(FATAL_ERROR "No R...")
endif()
include_directories(BEFORE ${LIBR_INCLUDE_DIRS})

@includes_directory@

add_custom_target(@project_name@ ALL
	COMMAND find ${CMAKE_SOURCE_DIR} -name "*.o" -exec rm "{}" "\;"
	COMMAND find ${CMAKE_SOURCE_DIR} -name "*.so" -exec rm "{}" "\;"
	COMMAND ${LIBR_EXECUTABLE} "--slave" "-e" "@roxygenize@"
	COMMAND ${LIBR_EXECUTABLE} CMD INSTALL "${CMAKE_SOURCE_DIR}")

