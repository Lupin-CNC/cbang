set(headers
    AxisAngle.h
    Matrix.h
    Path.h
    Quaternion.h
    Rectangle.h
    Segment.h
    Triangle.h
    Vector.h
)

add_library(geom INTERFACE)
target_include_directories(
  geom INTERFACE $<BUILD_INTERFACE:${cbang_SOURCE_DIR}/src>
)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/geom)
endif()
