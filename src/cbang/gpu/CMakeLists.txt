set(headers
    CUDALibrary.h
    ComputeDevice.h
    GPU.h
    GPUIndex.h
    GPUResource.h
    GPUType.h
    GPUVendor.h
    OpenCLLibrary.h
)

set(sources
    CUDALibrary.cpp
    ComputeDevice.cpp
    GPU.cpp
    GPUIndex.cpp
    GPUResource.cpp
    GPUType.cpp
    GPUVendor.cpp
    OpenCLLibrary.cpp
)

add_library(gpu OBJECT "${headers}" "${sources}")
target_include_directories(gpu PRIVATE "${Cbang_SOURCE_DIR}/src")
target_compile_definitions(gpu PRIVATE USING_CBANG)
set_property(TARGET gpu PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/gpu)
  install(TARGETS gpu EXPORT Cbang-targets)
endif()
