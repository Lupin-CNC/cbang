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
if (CBANG_MARIADB)
    list(APPEND sources $<TARGET_OBJECTS:maria>)
endif()

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

if(CBANG_BUILD_STATIC)
    add_library(Cbang STATIC "${headers}" "${sources}")
else()
    add_library(Cbang SHARED "${headers}" "${sources}")
endif()
target_link_options(Cbang PUBLIC "-pthread")
# add_library(Cbang::libcbang ALIAS Cbang)


target_include_directories(
    Cbang
    PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
    INTERFACE $<BUILD_INTERFACE:${Cbang_SOURCE_DIR}/src>
)
target_link_libraries(
    Cbang
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
target_compile_definitions(Cbang PRIVATE USING_CBANG)
set_property(TARGET Cbang PROPERTY POSITION_INDEPENDENT_CODE 1)

if(CMAKE_DL_LIBS)
    target_link_libraries(Cbang PRIVATE ${CMAKE_DL_LIBS})
endif()

if(LIB_RT)
    target_link_libraries(Cbang PRIVATE ${LIB_RT})
endif()

if(CBANG_OPENSSL)
    target_link_libraries(Cbang INTERFACE openssl)
endif()

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  if(WIN32 AND NOT CYGWIN)
    set(DEF_INSTALL_CMAKE_DIR CMake)
  else()
    set(DEF_INSTALL_CMAKE_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/Cbang)
  endif()

  set_target_properties(Cbang PROPERTIES
    FRAMEWORK           FALSE
    VERSION             ${CBANG_VERSION}
    SOVERSION           ${CBANG_SOVERSION}
    PUBLIC_HEADER       ${headers}
    DEFINE_SYMBOL       MAKE_CBANG_LIB
  )

  install(TARGETS Cbang
    EXPORT          Cbang-targets
    RUNTIME         DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY         DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE         DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang
    PUBLIC_HEADER   DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang
  )

  install(EXPORT Cbang-targets
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Cbang
  )

  configure_package_config_file(
    ${Cbang_SOURCE_DIR}/cmake/CbangConfig.cmake.in ${CMAKE_BINARY_DIR}/CbangConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Cbang
    PATH_VARS CMAKE_INSTALL_INCLUDEDIR
  )
  write_basic_package_version_file(${CMAKE_BINARY_DIR}/CbangConfigVersion.cmake
    VERSION ${CBANG_VERSION}
    COMPATIBILITY SameMajorVersion
  )
  install(FILES
    ${CMAKE_BINARY_DIR}/CbangConfig.cmake
    ${CMAKE_BINARY_DIR}/CbangConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Cbang
  )

#  set(INSTALL_CMAKE_DIR
#      ${DEF_INSTALL_CMAKE_DIR}
#      CACHE PATH "Installation directory for CMake files"
#  )
#
  install(FILES 
    ${headers} "${CMAKE_CURRENT_BINARY_DIR}/config.h"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/cbang"
  )
#
#  configure_file(
#    "${PROJECT_SOURCE_DIR}/cmake/CbangConfig.cmake.in"
#    "${PROJECT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/CbangConfig.cmake" @ONLY
#  )
#  install(
#    FILES "${PROJECT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/CbangConfig.cmake"
#    DESTINATION "${INSTALL_CMAKE_DIR}"
#  )
endif()
