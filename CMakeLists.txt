cmake_minimum_required(VERSION 3.14)
project(my_project)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Put all executables in build/bin
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# -----------------------
# Library
# -----------------------
add_library(my_lib src/hello.cpp)
target_include_directories(my_lib PUBLIC src)

# -----------------------
# Main Executable
# -----------------------
add_executable(my_app src/main.cpp)
target_link_libraries(my_app my_lib)

# -----------------------
# GoogleTest
# -----------------------
include(FetchContent)

FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)

set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

# -----------------------
# Tests
# -----------------------
add_executable(hello_test tests/hello_test.cc)

target_link_libraries(hello_test
  my_lib
  GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(hello_test)
