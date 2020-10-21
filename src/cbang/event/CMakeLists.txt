set(headers
    ACLHandler.h
    Base.h
    Buffer.h
    BufferDevice.h
    Client.h
    ConcurrentPool.h
    Connection.h
    ConnectionError.h
    DNSBase.h
    DNSRequest.h
    Enum.h
    Event.h
    EventFlag.h
    FD.h
    FDPool.h
    FDPoolEPoll.h
    FileHandler.h
    HTTPAccessHandler.h
    HTTPConn.h
    HTTPConnIn.h
    HTTPConnOut.h
    HTTPHandlerFactory.h
    HTTPHandlerGroup.h
    HTTPMethodMatcher.h
    HTTPOAuth2LoginHandler.h
    HTTPPatternMatcher.h
    HTTPRE2PatternMatcher.h
    HTTPRequestHandler.h
    HTTPServer.h
    HTTPSessionHandler.h
    HTTPStatus.h
    HTTPURLPatternMatcher.h
    Headers.h
    IndexHTMLHandler.h
    JSONWebsocket.h
    OAuth2Login.h
    OutgoingRequest.h
    Port.h
    RedirectSecure.h
    Request.h
    RequestMethod.h
    ResourceHTTPHandler.h
    RestoreURIPath.h
    Scheduler.h
    Server.h
    Transfer.h
    TransferRead.h
    TransferWrite.h
    WebServer.h
    WebsockOpCode.h
    WebsockStatus.h
    Websocket.h
)

set(sources
    ACLHandler.cpp
    Base.cpp
    Buffer.cpp
    Client.cpp
    ConcurrentPool.cpp
    Connection.cpp
    ConnectionError.cpp
    DNSBase.cpp
    DNSRequest.cpp
    Event.cpp
    EventFlag.cpp
    FD.cpp
    FDPool.cpp
    FDPoolEPoll.cpp
    FileHandler.cpp
    HTTPAccessHandler.cpp
    HTTPConn.cpp
    HTTPConnIn.cpp
    HTTPConnOut.cpp
    HTTPHandlerFactory.cpp
    HTTPHandlerGroup.cpp
    HTTPMethodMatcher.cpp
    HTTPOAuth2LoginHandler.cpp
    HTTPPatternMatcher.cpp
    HTTPRE2PatternMatcher.cpp
    HTTPRequestHandler.cpp
    HTTPServer.cpp
    HTTPSessionHandler.cpp
    HTTPURLPatternMatcher.cpp
    Headers.cpp
    IndexHTMLHandler.cpp
    JSONWebsocket.cpp
    OAuth2Login.cpp
    OutgoingRequest.cpp
    Port.cpp
    RedirectSecure.cpp
    Request.cpp
    ResourceHTTPHandler.cpp
    Server.cpp
    TransferRead.cpp
    TransferWrite.cpp
    WebServer.cpp
    WebsockOpCode.cpp
    WebsockStatus.cpp
    Websocket.cpp
)

add_library(event OBJECT "${headers}" "${sources}")
target_include_directories(
  event PRIVATE "${cbang_SOURCE_DIR}/src" "${cbang_BINARY_DIR}/src"
)
target_link_libraries(
  event
  PUBLIC
    Boost::iostreams
    expat::expat
    libevent::core
    re2::re2
)

if(CBANG_OPENSSL)
  target_link_libraries(event PUBLIC OpenSSL::Crypto OpenSSL::SSL)
endif()

target_compile_definitions(event PRIVATE USING_CBANG)

if(CBANG_VALGRIND)
  target_compile_definitions(event PRIVATE HAVE_VALGRIND)
endif()

set_property(TARGET event PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/event)
endif()
