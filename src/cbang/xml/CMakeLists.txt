set(headers
    ExpatXMLAdapter.h
    XIncludeHandler.h
    XMLAdapter.h
    XMLAttributes.h
    XMLFileTracker.h
    XMLHandler.h
    XMLHandlerContext.h
    XMLHandlerFactory.h
    XMLProcessor.h
    XMLReader.h
    XMLSkipHandler.h
    XMLValueMap.h
    XMLWriter.h
)

set(sources
    ExpatXMLAdapter.cpp
    XIncludeHandler.cpp
    XMLAdapter.cpp
    XMLAttributes.cpp
    XMLFileTracker.cpp
    XMLHandlerContext.cpp
    XMLProcessor.cpp
    XMLReader.cpp
    XMLSkipHandler.cpp
    XMLValueMap.cpp
    XMLWriter.cpp
)
include_directories("${Cbang_SOURCE_DIR}/src")

add_library(xml OBJECT "${headers}" "${sources}")
target_include_directories(
    xml PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
target_compile_definitions(xml PRIVATE USING_CBANG)
set_property(TARGET xml PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/xml)
  install(TARGETS xml EXPORT Cbang-targets)
endif()
