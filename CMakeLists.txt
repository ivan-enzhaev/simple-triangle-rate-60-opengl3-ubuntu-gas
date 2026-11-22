cmake_minimum_required(VERSION 3.21)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debub") # "Debug" or "Release"
endif()

project(simple-triangle-rate-60-opengl3-ubuntu-gas LANGUAGES C ASM)

add_executable(app src/main.S)

target_compile_options(app PRIVATE
    $<$<CONFIG:Debug>:-g>
)

target_link_options(app PRIVATE
    $<$<CONFIG:Release>:-s>
)

target_link_libraries(app PRIVATE X11 GL)
