set(headers
    HumanTime.h
    Time.h
    TimeInterval.h
    TimeStamp.h
    Timer.h
)

set(sources
    HumanTime.cpp
    Time.cpp
    TimeInterval.cpp
    Timer.cpp
)

add_library(time OBJECT "${headers}" "${sources}")
target_include_directories(time PRIVATE "${Cbang_SOURCE_DIR}/src")
target_link_libraries(time PUBLIC Boost::date_time)
target_compile_definitions(time PRIVATE USING_CBANG)
set_property(TARGET time PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/time)
  install(TARGETS time EXPORT Cbang-targets)
endif()
