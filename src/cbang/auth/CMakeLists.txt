set(headers
    FacebookOAuth2.h
    GitHubOAuth2.h
    GoogleOAuth2.h
    OAuth2.h
)

set(sources
    FacebookOAuth2.cpp
    GitHubOAuth2.cpp
    GoogleOAuth2.cpp
    OAuth2.cpp
)

add_library(auth OBJECT "${headers}" "${sources}")
target_include_directories(auth PRIVATE "${cbang_SOURCE_DIR}/src")
target_compile_definitions(auth PRIVATE USING_CBANG)
set_property(TARGET auth PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/auth)
endif()
