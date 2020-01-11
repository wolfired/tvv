cmake_minimum_required(VERSION 3.10)

project(tvv)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

include_directories(
    ./bridge
    ./built/include
)

link_directories(
    ./built/lib
)

add_subdirectory(bridge)
