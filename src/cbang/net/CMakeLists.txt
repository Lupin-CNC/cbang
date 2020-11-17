set(headers
    Base64.h
    IPAddress.h
    IPAddressFilter.h
    IPAddressRange.h
    IPRangeSet.h
    Session.h
    SessionManager.h
    Swab.h
    URI.h
)

set(sources
    Base64.cpp
    IPAddress.cpp
    IPAddressFilter.cpp
    IPAddressRange.cpp
    IPRangeSet.cpp
    Session.cpp
    SessionManager.cpp
    URI.cpp
)

add_library(net OBJECT "${headers}" "${sources}")
target_include_directories(
    net PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
if(CBANG_OPENSSL)
  target_link_libraries(net PUBLIC OpenSSL::Crypto OpenSSL::SSL)
endif()

target_compile_definitions(net PRIVATE USING_CBANG)
set_property(TARGET net PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/net)
endif()
