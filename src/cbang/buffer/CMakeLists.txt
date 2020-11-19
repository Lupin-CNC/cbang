set(headers Buffer.h BufferDevice.h MemoryBuffer.h)

set(sources Buffer.cpp MemoryBuffer.cpp)

add_library(buffer OBJECT "${headers}" "${sources}")
target_include_directories(buffer PRIVATE "${Cbang_SOURCE_DIR}/src")
target_link_libraries(buffer PUBLIC Boost::iostreams)
target_compile_definitions(buffer PRIVATE USING_CBANG)
set_property(TARGET buffer PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/buffer)
  install(TARGETS buffer EXPORT Cbang-targets)
endif()
