set(headers
    ASTNode.h
    ParseScope.h
    Scanner.h
    Token.h
    Tokenizer.h
)

set(sources Scanner.cpp)

add_library(parse OBJECT "${headers}" "${sources}")
target_include_directories(parse PRIVATE "${Cbang_SOURCE_DIR}/src")
target_compile_definitions(parse PRIVATE USING_CBANG)
set_property(TARGET parse PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/parse)
  install(TARGETS parse EXPORT Cbang-targets)
endif()
