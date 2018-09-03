cmake_minimum_required(VERSION 3.9)
project(contract)

set(CMAKE_CXX_STANDARD 11)

add_executable(hello
        hello/hello.cpp hello/hello.cpp)

include_directories(lib)