set(headers
    BIMemory.h
    BIOFStream.h
    BIOMemory.h
    BIOStream.h
    BIStream.h
    BOMemory.h
    BOStream.h
    BStream.h
    BigNum.h
    CRL.h
    CSR.h
    Certificate.h
    CertificateChain.h
    CertificateContext.h
    CertificateStore.h
    CertificateStoreContext.h
    Cipher.h
    Digest.h
    DigestStreamFilter.h
    Extension.h
    KeyContext.h
    KeyGenCallback.h
    KeyGenPacifier.h
    KeyPair.h
    PasswordCallback.h
    RSA.h
    Revoked.h
    SSL.h
    SSLContext.h
    SecurityUtilities.h
    XORStreamFilter.h
)

set(sources
    BIMemory.cpp
    BIStream.cpp
    BOMemory.cpp
    BOStream.cpp
    BStream.cpp
    BigNum.cpp
    CRL.cpp
    CSR.cpp
    Certificate.cpp
    CertificateChain.cpp
    CertificateContext.cpp
    CertificateStore.cpp
    CertificateStoreContext.cpp
    Cipher.cpp
    Digest.cpp
    Extension.cpp
    KeyContext.cpp
    KeyGenPacifier.cpp
    KeyPair.cpp
    RSA.cpp
    Revoked.cpp
    SSL.cpp
    SSLContext.cpp
    SecurityUtilities.cpp
)

add_library(openssl OBJECT "${headers}" "${sources}")
target_include_directories(
    openssl PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
target_link_libraries(
  openssl PUBLIC Boost::iostreams OpenSSL::Crypto OpenSSL::SSL
)
target_compile_definitions(openssl PRIVATE USING_CBANG)

if(CBANG_VALGRIND)
  target_compile_definitions(openssl PRIVATE HAVE_VALGRIND)
endif()

set_property(TARGET openssl PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(
    FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/openssl
  )
endif()
