set(headers
    BIOSocketImpl.h
    Socket.h
    SocketConnection.h
    SocketDebugConnection.h
    SocketDebugImpl.h
    SocketDebugger.h
    SocketDefaultImpl.h
    SocketDevice.h
    SocketImpl.h
    SocketSSLImpl.h
    SocketServer.h
    SocketSet.h
    SocketType.h
    Winsock.h
)

set(sources
    BIOSocketImpl.cpp
    Socket.cpp
    SocketDebugImpl.cpp
    SocketDebugger.cpp
    SocketDefaultImpl.cpp
    SocketImpl.cpp
    SocketSSLImpl.cpp
    SocketServer.cpp
    SocketSet.cpp
)

add_library(socket OBJECT "${headers}" "${sources}")
target_include_directories(
    socket PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
target_link_libraries(socket PUBLIC Boost::iostreams)

if(CBANG_OPENSSL)
  target_link_libraries(socket PUBLIC OpenSSL::Crypto OpenSSL::SSL)
endif()

target_compile_definitions(socket PRIVATE USING_CBANG)
set_property(TARGET socket PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/socket)
endif()
