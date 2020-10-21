set(headers
    BufferWriter.h
    Builder.h
    Dict.h
    Factory.h
    False.h
    Filter.h
    Integer.h
    JSON.h
    KeywordFilter.h
    KeywordsFilter.h
    List.h
    Null.h
    NullSink.h
    Number.h
    Observable.h
    Path.h
    ProxySink.h
    Reader.h
    Serializable.h
    Sink.h
    String.h
    TeeSink.h
    True.h
    Undefined.h
    Value.h
    ValueType.h
    Writer.h
    YAMLMergeSink.h
    YAMLReader.h
)

set(sources
    Builder.cpp
    Dict.cpp
    Factory.cpp
    False.cpp
    Filter.cpp
    List.cpp
    Null.cpp
    NullSink.cpp
    Path.cpp
    ProxySink.cpp
    Reader.cpp
    Serializable.cpp
    Sink.cpp
    String.cpp
    TeeSink.cpp
    True.cpp
    Undefined.cpp
    Value.cpp
    ValueType.cpp
    Writer.cpp
    YAMLMergeSink.cpp
    YAMLReader.cpp
)

add_library(json OBJECT "${headers}" "${sources}")
target_include_directories(json PRIVATE "${cbang_SOURCE_DIR}/src")
target_link_libraries(json PUBLIC yaml)
target_compile_definitions(json PRIVATE USING_CBANG)
set_property(TARGET json PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(
    FILES ${headers} ValueTypes.def
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/json
  )
endif()
