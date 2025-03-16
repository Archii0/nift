enable_testing()

find_package(GTest REQUIRED)

file(GLOB TEST_SOURCES "test_*.cpp")
add_executable(runTests ${TEST_SOURCES})

# Link Google Test
target_link_libraries(runTests PRIVATE GTest::GTest GTest::Main pthread)

# Register tests
add_test(NAME MyTests COMMAND runTests)
    