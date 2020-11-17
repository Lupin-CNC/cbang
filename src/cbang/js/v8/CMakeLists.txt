set(headers
    Context.h
    Factory.h
    JSImpl.h
    V8.h
    Value.h
    ValueRef.h
)

set(sources
    Context.cpp
    Factory.cpp
    JSImpl.cpp
    Value.cpp
)

add_library(v8 OBJECT "${headers}" "${sources}")
target_include_directories(v8 PRIVATE "${Cbang_SOURCE_DIR}/src")
target_compile_definitions(v8 PRIVATE USING_CBANG)
set_property(TARGET v8 PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/v8)
endif()
