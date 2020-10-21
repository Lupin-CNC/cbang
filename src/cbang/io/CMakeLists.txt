set(headers
    File.h
    FileFactory.h
    FileInterface.h
    IO.h
    InputSource.h
    OutputSink.h
    Parser.h
    Reader.h
    StringInputSource.h
    StringStreamInputSource.h
    UnixFile.h
    Writer.h
)

set(sources
    File.cpp
    InputSource.cpp
    OutputSink.cpp
    Parser.cpp
    UnixFile.cpp
)

add_library(io OBJECT "${headers}" "${sources}")
target_include_directories(io PRIVATE "${cbang_SOURCE_DIR}/src")
target_link_libraries(io PUBLIC Boost::iostreams)

if(CBANG_OPENSSL)
  target_link_libraries(io PUBLIC OpenSSL::Crypto OpenSSL::SSL)
endif()

target_compile_definitions(io PRIVATE USING_CBANG)
set_property(TARGET io PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/io)
endif()
