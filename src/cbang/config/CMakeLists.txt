set(headers
    CommandLine.h
    Constraint.h
    EnumConstraint.h
    MaxConstraint.h
    MinConstraint.h
    MinMaxConstraint.h
    Option.h
    OptionAction.h
    OptionActionSet.h
    OptionCategory.h
    OptionMap.h
    OptionProxy.h
    OptionScriptHandler.h
    Options.h
)

set(sources
    CommandLine.cpp
    Option.cpp
    OptionCategory.cpp
    OptionMap.cpp
    OptionProxy.cpp
    OptionScriptHandler.cpp
    Options.cpp
)

add_library(config OBJECT "${headers}" "${sources}")
target_include_directories(config PRIVATE "${Cbang_SOURCE_DIR}/src")
target_compile_definitions(config PRIVATE USING_CBANG)
set_property(TARGET config PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/config)
  install(TARGETS config EXPORT Cbang-targets)
endif()
