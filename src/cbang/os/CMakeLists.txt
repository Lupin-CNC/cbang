set(headers
    CPUID.h
    Condition.h
    Directory.h
    DirectoryWalker.h
    DynamicLibrary.h
    ExitSignalHandler.h
    Glob.h
    Mutex.h
    MutexPrivate.h
    PowerManagement.h
    ProcessLock.h
    RWLock.h
    Semaphore.h
    SignalHandler.h
    SignalManager.h
    Subprocess.h
    SysError.h
    SystemInfo.h
    SystemUtilities.h
    TemporaryDirectory.h
    Thread.h
    ThreadLocalStorage.h
    ThreadPool.h
    ThreadPoolFunc.h
    Win32EventLog.h
    Win32Registry.h
    Win32Utilities.h
)

set(sources
    CPUID.cpp
    Condition.cpp
    Directory.cpp
    DirectoryWalker.cpp
    DynamicLibrary.cpp
    ExitSignalHandler.cpp
    Glob.cpp
    Mutex.cpp
    PowerManagement.cpp
    ProcessLock.cpp
    RWLock.cpp
    Semaphore.cpp
    SignalManager.cpp
    Subprocess.cpp
    SysError.cpp
    SystemInfo.cpp
    SystemUtilities.cpp
    TemporaryDirectory.cpp
    Thread.cpp
    ThreadPool.cpp
    Win32EventLog.cpp
    Win32Registry.cpp
    Win32Utilities.cpp
)

add_library(os OBJECT "${headers}" "${sources}")
target_include_directories(
    os PRIVATE "${Cbang_SOURCE_DIR}/src" "${Cbang_BINARY_DIR}/src"
)
target_link_libraries(
  os PUBLIC Boost::filesystem Boost::iostreams Boost::date_time
)
target_compile_definitions(os PRIVATE USING_CBANG)

if(CBANG_VALGRIND)
  target_compile_definitions(os PRIVATE HAVE_VALGRIND)
endif()

set_property(TARGET os PROPERTY POSITION_INDEPENDENT_CODE 1)

if(APPLE)
  target_link_libraries(
    os PUBLIC "-framework CoreFoundation" "-framework IOKit"
  )
  set_target_properties(os PROPERTIES LINK_FLAGS "-Wl,-F/Library/Frameworks")
endif()

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/os)
  install(TARGETS os EXPORT Cbang-targets)
endif()
