set(headers
    Arguments.h
    BareMemberFunctor.h
    Connection.h
    Context.h
    Entity.h
    Environment.h
    Function.h
    Functor.h
    Handler.h
    KeywordArguments.h
    MemberFunctor.h
    Processor.h
    Server.h
    StdLibrary.h
    Variable.h
)

set(sources
    Arguments.cpp
    Connection.cpp
    Entity.cpp
    Environment.cpp
    Function.cpp
    Handler.cpp
    KeywordArguments.cpp
    Processor.cpp
    Server.cpp
    StdLibrary.cpp
    Variable.cpp
)

add_library(script OBJECT "${headers}" "${sources}")
target_include_directories(script PRIVATE "${Cbang_SOURCE_DIR}/src")
# target_link_libraries(script PUBLIC Boost::iostreams)
target_link_libraries(script PUBLIC ${Boost_IOSTREAMS_LIBRARY})
target_compile_definitions(script PRIVATE USING_CBANG)
set_property(TARGET script PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/script)
  install(TARGETS script EXPORT Cbang-targets)
endif()
