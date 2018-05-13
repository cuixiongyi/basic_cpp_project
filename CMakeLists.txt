cmake_minimum_required(VERSION 3.0)
project(git-clang-format-cmake)

include(cmake/clang-format/clang-format.cmake)


add_subdirectory(library)

include_directories(library/include/)

add_executable (main
        Main.h Main.cpp
        )

#include_directories(${GTEST_INCLUDE_DIRS})
target_link_libraries(main PRIVATE
#        ${Boost_LIBRARIES}
        library
        )
