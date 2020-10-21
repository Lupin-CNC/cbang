if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(
    FILES MakeStruct.def DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/struct
  )
endif()
