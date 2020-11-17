set(headers
    BacktraceDebugger.h
    Debugger.h
    Demangle.h
    StackFrame.h
    StackTrace.h
)

set(sources
    BacktraceDebugger.cpp
    Debugger.cpp
    Demangle.cpp
    StackFrame.cpp
    StackTrace.cpp
)

add_library(debug OBJECT "${headers}" "${sources}")
target_include_directories(
    debug PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
target_compile_definitions(debug PRIVATE USING_CBANG)

if(CBANG_VALGRIND)
  target_compile_definitions(debug PRIVATE HAVE_VALGRIND)
endif()

set_property(TARGET debug PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/debug)
endif()
