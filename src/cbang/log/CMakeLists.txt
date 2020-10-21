set(headers
    AsyncCopyStreamToLog.h
    LogDevice.h
    LogLineBuffer.h
    Logger.h
    SmartLogPrefix.h
    TailFileToLog.h
)

set(sources
    AsyncCopyStreamToLog.cpp
    LogDevice.cpp
    LogLineBuffer.cpp
    Logger.cpp
    TailFileToLog.cpp
)

add_library(log OBJECT "${headers}" "${sources}")
target_include_directories(
  log PRIVATE "${cbang_SOURCE_DIR}/src" "${cbang_BINARY_DIR}/src"
)
target_link_libraries(log PUBLIC Boost::iostreams)
target_compile_definitions(log PRIVATE USING_CBANG)
set_property(TARGET log PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/log)
endif()
