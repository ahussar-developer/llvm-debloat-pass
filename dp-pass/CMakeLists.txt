cmake_minimum_required(VERSION 3.13.4)
add_library(DebloatPass MODULE DebloatPass.cpp)

set_target_properties(DebloatPass PROPERTIES
    COMPILE_FLAGS "-fno-rtti"
)


