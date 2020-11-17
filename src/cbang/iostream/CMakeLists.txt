set(headers
    ArrayDevice.h
    BZip2Compressor.h
    BZip2Decompressor.h
    Base64Encoder.h
    CipherStream.h
    CompressionFilter.h
    CountingStreamFilter.h
    LZ4Compressor.h
    LZ4Decompressor.h
    LineBufferDevice.h
    NullDevice.h
    PacifierCallback.h
    Serializable.h
    StreamLimiter.h
    TeeFilter.h
    Transfer.h
    UpdateStreamFilter.h
    VectorDevice.h
)

set(sources PacifierCallback.cpp Transfer.cpp)

add_library(iostream OBJECT "${headers}" "${sources}")
target_include_directories(iostream PRIVATE "${Cbang_SOURCE_DIR}/src")
target_link_libraries(iostream PUBLIC Boost::iostreams BZip2::BZip2 lz4::lz4)
target_compile_definitions(iostream PRIVATE USING_CBANG)
set_property(TARGET iostream PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(
    FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/iostream
  )
endif()
