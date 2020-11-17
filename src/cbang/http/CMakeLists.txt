set(headers
    ACLWebPageHandler.h
    ChunkedStreamFilter.h
    Connection.h
    ConnectionDevice.h
    ConnectionQueue.h
    ContentTypes.h
    Context.h
    Cookie.h
    FileWebPageHandler.h
    Handler.h
    Header.h
    Message.h
    MethodWebPageHandler.h
    ProxyManager.h
    RegexWebPageHandler.h
    Request.h
    RequestMethod.h
    ResourceWebPageHandler.h
    Response.h
    ScriptWebPageHandler.h
    ScriptedWebContext.h
    ScriptedWebHandler.h
    Server.h
    Session.h
    SessionFactory.h
    SessionManager.h
    SessionsTable.h
    StatusCode.h
    Transaction.h
    WebContext.h
    WebContextMethods.h
    WebHandler.h
    WebPageHandler.h
    WebPageHandlerGroup.h
    WebServer.h
)

set(sources
    ACLWebPageHandler.cpp
    Connection.cpp
    ConnectionDevice.cpp
    ConnectionQueue.cpp
    ContentTypes.cpp
    Context.cpp
    Cookie.cpp
    FileWebPageHandler.cpp
    Handler.cpp
    Header.cpp
    Message.cpp
    ProxyManager.cpp
    Request.cpp
    RequestMethod.cpp
    ResourceWebPageHandler.cpp
    Response.cpp
    ScriptWebPageHandler.cpp
    ScriptedWebContext.cpp
    ScriptedWebHandler.cpp
    Server.cpp
    Session.cpp
    SessionManager.cpp
    SessionsTable.cpp
    StatusCode.cpp
    Transaction.cpp
    WebContext.cpp
    WebContextMethods.cpp
    WebHandler.cpp
    WebPageHandlerGroup.cpp
    WebServer.cpp
)

add_library(http OBJECT "${headers}" "${sources}")
target_include_directories(
    http PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
target_link_libraries(http PUBLIC Boost::iostreams)

if(CBANG_LEVELDB)
  target_link_libraries(http PUBLIC leveldb::leveldb)
endif()

if(CBANG_OPENSSL)
  target_link_libraries(http PUBLIC OpenSSL::Crypto OpenSSL::SSL)
endif()

target_compile_definitions(http PRIVATE USING_CBANG)

if(CBANG_VALGRIND)
  target_compile_definitions(http PRIVATE HAVE_VALGRIND)
endif()

set_property(TARGET http PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/http)
endif()
