set(headers PCIDevice.h PCIInfo.h PCIVendor.h)

set(sources PCIDevice.cpp PCIInfo.cpp PCIVendor.cpp)

add_library(pci OBJECT "${headers}" "${sources}")
target_include_directories(pci PRIVATE "${Cbang_SOURCE_DIR}/src")
target_compile_definitions(pci PRIVATE USING_CBANG)
set_property(TARGET pci PROPERTY POSITION_INDEPENDENT_CODE 1)

if(APPLE)
  target_link_libraries(
    os PUBLIC "-framework CoreFoundation" "-framework IOKit"
  )
  set_target_properties(os PROPERTIES LINK_FLAGS "-Wl,-F/Library/Frameworks")
endif()

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/pci)
  install(TARGETS pci EXPORT Cbang-targets)
endif()
