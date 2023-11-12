project("debloat-pass")
cmake_minimum_required(VERSION 3.4)

set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

find_package(LLVM REQUIRED CONFIG)
add_definitions(${LLVM_DEFINITIONS})
message("LLVM_INCLUDE_DIRS: ${LLVM_INCLUDE_DIRS}")

include_directories(${LLVM_INCLUDE_DIRS})
message("LLVM_INCLUDE_DIRS: ${LLVM_INCLUDE_DIRS}") 

link_directories(${LLVM_LIBRARY_DIRS})
message("LLVM_LIBRARY_DIRS: ${LLVM_LIBRARY_DIRS}") 

add_subdirectory(dp-pass)
