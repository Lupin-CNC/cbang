set(headers
    EnumerationPacketField.h
    FPPacketField.h
    Packet.h
    PacketField.h
    StringPacketField.h
)

set(sources Packet.cpp StringPacketField.cpp)

add_library(packet OBJECT "${headers}" "${sources}")
target_include_directories(packet PRIVATE "${Cbang_SOURCE_DIR}/src")
target_compile_definitions(packet PRIVATE USING_CBANG)
set_property(TARGET packet PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/packet)
endif()
