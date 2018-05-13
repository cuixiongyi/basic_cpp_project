cmake_minimum_required(VERSION 3.0)
# from https://github.com/kbenzie/git-cmake-format

find_package(Git REQUIRED)
find_package(PythonInterp REQUIRED)

set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/clang-format)
list(APPEND CMAKE_MODULE_PATH ${CURRENT_DIR})
find_package(ClangFormat REQUIRED)

set(GCF_CLANGFORMAT_STYLE "${CMAKE_SOURCE_DIR}/.clang-format" CACHE STRING
        "Parameter pass to clang-format -style=<here>")
set(GCF_IGNORE_LIST "" CACHE STRING
        "Semi colon separated list of directories to ignore")
set(GCF_SCRIPT ${CURRENT_DIR}/git-cmake-format.py)

execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --show-toplevel
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GCF_GIT_ROOT
        OUTPUT_STRIP_TRAILING_WHITESPACE)
if(NOT GCF_GIT_ROOT)
    message(WARNING "Not in a git repository")
else()
    configure_file(
            ${CURRENT_DIR}/git-pre-commit-hook
            ${GCF_GIT_ROOT}/.git/hooks/pre-commit
            @ONLY)
    unset(GCF_GIT_ROOT)

    add_custom_target(clang-format
            ${PYTHON_EXECUTABLE} ${GCF_SCRIPT}
            --cmake ${GIT_EXECUTABLE}
            ${CLANG_FORMAT_EXECUTABLE} -style=${GCF_CLANGFORMAT_STYLE}
            -ignore=${GCF_IGNORE_LIST}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
    unset(GCF_SCRIPT)
endif()
