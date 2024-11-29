cmake_minimum_required(VERSION 3.26)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}")
project(whisppr)

# 1. Packages avec un module CMake présent sur le système
# ex. ZLIB: (/usr/share/cmake/Modules/FindZLIB.cmake)
find_package(ZLIB REQUIRED)

# 2. Packages avec un module CMake custom
# ex. Ce dépôt: FindPipeWire.cmake + CMAKE_MODULE_PATH
if(LINUX)
  find_package(PipeWire REQUIRED)
endif()

# 3. Packages externes façon package manager
include(FetchContent)
FetchContent_Declare(
    whisper
    GIT_REPOSITORY https://github.com/ggerganov/whisper.cpp
    GIT_TAG        master
)

FetchContent_MakeAvailable(whisper)


add_executable(tut1 tut1.cpp)

target_link_libraries(tut1 PRIVATE m whisper)
if(LINUX)
    target_link_libraries(tut1 PRIVATE PipeWire::PipeWire)
elseif(APPLE)
    # etc.
elseif(WIN32)
    # etc.
endif()

