set(headers
    ACLSet.h
    Array.h
    BZip2.h
    Base.h
    Boolean.h
    CompilerInfo.h
    Features.h
    HexString.h
    HumanNumber.h
    HumanSize.h
    ID.h
    LineBuffer.h
    Lockable.h
    MacroUtils.h
    Named.h
    NonCopyable.h
    OrderedDict.h
    Progress.h
    Random.h
    Rate.h
    RateSet.h
    Regex.h
    Resource.h
    SPSCQueue.h
    SaveOStreamConfig.h
    Singleton.h
    SmartDepth.h
    SmartFunction.h
    SmartFunctor.h
    SmartInc.h
    SmartLock.h
    SmartReadLock.h
    SmartToggle.h
    SmartUnlock.h
    SmartWriteLock.h
    StreamLineBuffer.h
    StringMap.h
    StringOrNull.h
    StructPrinter.h
    UniqueID.h
    Variant.h
    Version.h
)

set(sources
    ACLSet.cpp
    BZip2.cpp
    HumanNumber.cpp
    HumanSize.cpp
    ID.cpp
    LineBuffer.cpp
    Progress.cpp
    Random.cpp
    Regex.cpp
    Resource.cpp
    Singleton.cpp
    Variant.cpp
)

add_library(util OBJECT "${headers}" "${sources}")
target_include_directories( util PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src")
# target_link_libraries(util PRIVATE Boost::regex BZip2::BZip2)
target_link_libraries(util PUBLIC ${Boost_REGEX_LIBRARY} ${BZIP2_LIBRARIES})

if(CBANG_OPENSSL)
    # target_link_libraries(util PUBLIC OpenSSL::Crypto OpenSSL::SSL)
    target_link_libraries(util PUBLIC ${OPENSSL_CRYPTO_LIBRARY} ${OPENSSL_SSL_LIBRARY})
endif()

target_compile_definitions(util PRIVATE USING_CBANG)
set_property(TARGET util PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/util)
  install(TARGETS util EXPORT Cbang-targets)
endif()
