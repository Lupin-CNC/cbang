set(headers Account.h KeyCert.h)

set(sources Account.cpp KeyCert.cpp)


add_library(acmev2 OBJECT "${headers}" "${sources}")
target_include_directories(
    acmev2 PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
target_compile_definitions(acmev2 PRIVATE USING_CBANG)
set_property(TARGET acmev2 PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/acmev2)
endif()
