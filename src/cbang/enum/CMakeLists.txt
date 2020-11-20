set(headers
    CPUExtendedFeature.h
    CPUFeature.h
    CPUFeature80000001.h
    Compression.h
    Enumeration.h
    EnumerationManager.h
    ProcessPriority.h
    ThreadsType.h
    MakeEnumeration.def
    MakeEnumerationImpl.def
)
set_source_files_properties(MakeEnumeration.def PROPERTIES HEADER_FILE_ONLY TRUE)
set_source_files_properties(MakeEnumerationImpl.def PROPERTIES HEADER_FILE_ONLY TRUE)

set(sources
    CPUExtendedFeature.cpp
    CPUFeature.cpp
    CPUFeature80000001.cpp
    Compression.cpp
    EnumerationManager.cpp
    ProcessPriority.cpp
    ThreadsType.cpp
)

add_library(enum OBJECT "${headers}" "${sources}")
target_include_directories(enum PRIVATE "${Cbang_SOURCE_DIR}/src")
target_compile_definitions(enum PRIVATE USING_CBANG)
set_property(TARGET enum PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(
    FILES ${headers} MakeEnumeration.def
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/enum
  )
endif()
