if(CBANG_CHAKRA)
  add_subdirectory(chakra)
endif()

if(CBANG_V8)
  add_subdirectory(v8)
endif()

set(headers
    BakedCallback.h
    Callback.h
    ConsoleModule.h
    Factory.h
    Function.h
    Impl.h
    JSInterrupted.h
    Javascript.h
    MethodCallback.h
    Module.h
    NativeModule.h
    PathResolver.h
    RawMethodCallback.h
    Scope.h
    Signature.h
    Sink.h
    StdModule.h
    Value.h
)

set(sources
    BakedCallback.cpp
    Callback.cpp
    ConsoleModule.cpp
    Function.cpp
    Javascript.cpp
    PathResolver.cpp
    Signature.cpp
    Sink.cpp
    StdModule.cpp
    Value.cpp
)

add_library(js OBJECT "${headers}" "${sources}")
target_include_directories(js PRIVATE "${cbang_SOURCE_DIR}/src")
target_compile_definitions(js PRIVATE USING_CBANG)
set_property(TARGET js PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/js)
endif()
