set(headers
    Context.h
    Factory.h
    JSImpl.h
    Value.h
    ValueRef.h
)

set(sources
    Context.cpp
    Factory.cpp
    JSImpl.cpp
    Value.cpp
    ValueRef.cpp
)

add_library(chakra OBJECT "${headers}" "${sources}")
target_include_directories(chakra PRIVATE "${Cbang_SOURCE_DIR}/src")
target_compile_definitions(chakra PRIVATE USING_CBANG)
set_property(TARGET chakra PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/chakra)
endif()
