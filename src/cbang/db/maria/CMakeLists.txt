set(headers DB.h EventDB.h Field.h)

set(sources DB.cpp EventDB.cpp Field.cpp)

add_library(maria OBJECT "${headers}" "${sources}")
target_include_directories(
    maria PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
target_link_libraries(maria PUBLIC libmysql)
target_compile_definitions(maria PRIVATE USING_CBANG)
set_property(TARGET maria PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/maria)
endif()
