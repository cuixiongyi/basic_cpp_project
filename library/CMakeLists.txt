cmake_minimum_required (VERSION 3.0)

include_directories(include/)
set(src
        library.cpp
        )
set(header
        include/library/library.h
        )


add_library(library ${header} ${src})

target_link_libraries(library
#        ${Boost_LIBRARIES}
        )
install(TARGETS library DESTINATION lib)
install(DIRECTORY include/ DESTINATION include)
