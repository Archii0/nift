cmake_minimum_required(VERSION 3.10)

project(PROJECTNAME VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

include_directories(include)
file(GLOB SOURCES "src/*.cpp")

add_executable(PROJECTNAME ${SOURCES})

enable_testing()
add_subdirectory(tests)

set_target_properties(PROJECTNAME PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)


find_package(Doxygen)

if(DOXYGEN_FOUND)
    message(STATUS "Doxygen found at ${DOXYGEN_EXECUTABLE}")
    set(DOXYGEN_INPUT_DIR "${CMAKE_SOURCE_DIR}/src")  # Set the correct input directory
    set(DOXYGEN_OUTPUT_DIR "${CMAKE_BINARY_DIR}/docs")

    # Make sure the output directory exists
    file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIR})

    # Add a custom target to generate documentation
    add_custom_target(doc
        COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Doxyfile
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM
    )
else()
    message(WARNING "Doxygen not found!")
endif()




# find_package(Doxygen)

# if(DOXYGEN_FOUND)
#     set(DOXYGEN_INPUT_DIR "${CMAKE_SOURCE_DIR}/src")
#     set(DOXYGEN_OUTPUT_DIR "${CMAKE_BINARY_DIR}/docs")

#     add_custom_target(doc Doxygen ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
#     add_dependencies(doc PROJECTNAME)
# endif()