# PROJECTNAME

## Overview
Description here.

Uses **Google Test** for unit testing and CMake build configuration.

## Dependencies
- **CMake**: Version 3.10 or higher
- **Google Test**: Automatically fetched and built using CMake

## Build Instructions

1. **Clone the repository**:
    ```sh
    git clone https://github.com/username/PROJECTNAME.git
    cd PROJECTNAME
    ```

2. **Create the build directory**:
    ```sh
    mkdir -p build && cd build
    ```

3. **Run CMake to configure the project**:
    ```sh
    cmake ..
    ```

4. **Build the project**:
    ```sh
    make
    ```

5. **Run the main executable**:
    ```sh
    ./bin/PROJECTNAME
    ```

6. **Run tests**:
    To run all tests, use:
    ```sh
    ctest
    ```

    Or directly run the test executable:
    ```sh
    ./tests/runTests
    ```