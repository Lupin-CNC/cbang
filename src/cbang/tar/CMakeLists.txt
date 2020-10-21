set(headers
    Tar.h
    TarFileReader.h
    TarFileWriter.h
    TarHeader.h
)

set(sources
    Tar.cpp
    TarFileReader.cpp
    TarFileWriter.cpp
    TarHeader.cpp
)

add_library(tar OBJECT "${headers}" "${sources}")
target_include_directories(tar PRIVATE "${cbang_SOURCE_DIR}/src")
target_compile_definitions(tar PRIVATE USING_CBANG)
set_property(TARGET tar PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/tar)
endif()
