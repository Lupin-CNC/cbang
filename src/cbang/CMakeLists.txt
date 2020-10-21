include(GNUInstallDirs)

add_subdirectory(acmev2)
add_subdirectory(auth)
add_subdirectory(buffer)
add_subdirectory(config)
add_subdirectory(db)
add_subdirectory(debug)
add_subdirectory(enum)
add_subdirectory(event)
add_subdirectory(geom)
add_subdirectory(gpu)
add_subdirectory(http)
add_subdirectory(io)
add_subdirectory(iostream)
add_subdirectory(json)
add_subdirectory(log)
add_subdirectory(net)

if(CBANG_OPENSSL)
  add_subdirectory(openssl)
endif()

add_subdirectory(os)
add_subdirectory(packet)
add_subdirectory(parse)
add_subdirectory(pci)
add_subdirectory(script)
add_subdirectory(socket)
add_subdirectory(struct)
add_subdirectory(tar)
add_subdirectory(time)
add_subdirectory(util)
add_subdirectory(xml)

set(headers
    Application.h
    ApplicationMain.h
    Catch.h
    Deallocators.h
    Errors.h
    Exception.h
    FileLocation.h
    Info.h
    LocationRange.h
    Math.h
    Packed.h
    RefCounter.h
    SStream.h
    ServerApplication.h
    SmartPointer.h
    StdTypes.h
    String.h
    Throw.h
    Zap.h
)

set(sources
    Application.cpp
    Exception.cpp
    FileLocation.cpp
    Info.cpp
    LocationRange.cpp
    RefCounter.cpp
    ServerApplication.cpp
    SmartPointer.cpp
    String.cpp
    $<TARGET_OBJECTS:acmev2>
    $<TARGET_OBJECTS:auth>
    $<TARGET_OBJECTS:buffer>
    $<TARGET_OBJECTS:config>
    $<TARGET_OBJECTS:db>
    $<TARGET_OBJECTS:maria>
    $<TARGET_OBJECTS:debug>
    $<TARGET_OBJECTS:enum>
    $<TARGET_OBJECTS:event>
    $<TARGET_OBJECTS:gpu>
    $<TARGET_OBJECTS:http>
    $<TARGET_OBJECTS:io>
    $<TARGET_OBJECTS:iostream>
    $<TARGET_OBJECTS:json>
    $<TARGET_OBJECTS:log>
    $<TARGET_OBJECTS:net>
    $<TARGET_OBJECTS:os>
    $<TARGET_OBJECTS:packet>
    $<TARGET_OBJECTS:parse>
    $<TARGET_OBJECTS:pci>
    $<TARGET_OBJECTS:script>
    $<TARGET_OBJECTS:socket>
    $<TARGET_OBJECTS:tar>
    $<TARGET_OBJECTS:time>
    $<TARGET_OBJECTS:util>
    $<TARGET_OBJECTS:xml>
)

if(CBANG_CHAKRA OR CBANG_V8)
  add_subdirectory(js)
  list(APPEND sources $<TARGET_OBJECTS:js>)
endif()

if(CBANG_CHAKRA)
  list(APPEND sources $<TARGET_OBJECTS:chakra>)
endif()

if(CBANG_BACKTRACE)
  set(CBANG_BACKTRACE_PP "define")
else()
  set(CBANG_BACKTRACE_PP "undef")
endif()

if(CBANG_LEVELDB)
  set(CBANG_LEVELDB_PP "define")
else()
  set(CBANG_LEVELDB_PP "undef")
endif()

if(LINUX)
  set(CBANG_EPOLL_PP "define")
else()
  set(CBANG_EPOLL_PP "undef")
endif()

if(CBANG_OPENSSL)
  list(APPEND sources $<TARGET_OBJECTS:openssl>)
  set(CBANG_OPENSSL_PP "define")
else()
  set(CBANG_OPENSSL_PP "undef")
endif()

if(CBANG_V8)
  list(APPEND sources $<TARGET_OBJECTS:v8>)
endif()

configure_file("config.h.in" "${CMAKE_CURRENT_BINARY_DIR}/config.h" @ONLY)

add_library(cbang "${headers}" "${sources}")
add_library(Cbang::libcbang ALIAS cbang)
target_include_directories(
  cbang
  PRIVATE "${cbang_SOURCE_DIR}/src" "${cbang_BINARY_DIR}/src"
  INTERFACE $<BUILD_INTERFACE:${cbang_SOURCE_DIR}/src>
)
target_link_libraries(
  cbang
  INTERFACE
    acmev2
    auth
    buffer
    config
    db
    debug
    enum
    event
    gpu
    http
    io
    iostream
    json
    log
    net
    os
    packet
    parse
    pci
    script
    socket
    tar
    time
    util
    xml
)
target_compile_definitions(cbang PRIVATE USING_CBANG)
set_property(TARGET cbang PROPERTY POSITION_INDEPENDENT_CODE 1)

if(CMAKE_DL_LIBS)
  target_link_libraries(cbang PRIVATE ${CMAKE_DL_LIBS})
endif()

if(LIB_RT)
  target_link_libraries(cbang PRIVATE ${LIB_RT})
endif()

if(CBANG_OPENSSL)
  target_link_libraries(cbang INTERFACE openssl)
endif()

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  if(WIN32 AND NOT CYGWIN)
    set(DEF_INSTALL_CMAKE_DIR CMake)
  else()
    set(DEF_INSTALL_CMAKE_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/Cbang)
  endif()

  set(INSTALL_CMAKE_DIR
      ${DEF_INSTALL_CMAKE_DIR}
      CACHE PATH "Installation directory for CMake files"
  )

  install(
    FILES ${headers} "${CMAKE_CURRENT_BINARY_DIR}/config.h"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/cbang"
  )

  configure_file(
    "${PROJECT_SOURCE_DIR}/cmake/CbangConfig.cmake.in"
    "${PROJECT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/CbangConfig.cmake" @ONLY
  )
  install(
    FILES "${PROJECT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/CbangConfig.cmake"
    DESTINATION "${INSTALL_CMAKE_DIR}"
  )
endif()
