add_subdirectory(maria)

set(headers
    AsyncLevelDB.h
    Backup.h
    Blob.h
    Column.h
    ColumnDef.h
    Database.h
    LevelDB.h
    NameValueTable.h
    Parameter.h
    Schema.h
    Statement.h
    TableDef.h
    Transaction.h
    Types.h
)

set(sources
    Backup.cpp
    Blob.cpp
    Column.cpp
    Database.cpp
    LevelDB.cpp
    NameValueTable.cpp
    Parameter.cpp
    Schema.cpp
    Statement.cpp
    TableDef.cpp
    Transaction.cpp
)

add_library(db OBJECT "${headers}" "${sources}")
target_include_directories(
  db PRIVATE "${cbang_SOURCE_DIR}/src" "${cbang_BINARY_DIR}/src"
)

target_link_libraries(db PUBLIC unofficial::sqlite3::sqlite3)

if(CBANG_LEVELDB)
  target_include_directories(db PRIVATE "${leveldb_INCLUDE_DIR}")
  target_link_libraries(db PUBLIC leveldb::leveldb)
endif()

target_compile_definitions(db PRIVATE USING_CBANG)
set_property(TARGET db PROPERTY POSITION_INDEPENDENT_CODE 1)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  install(
    FILES ${headers} MakeTable.def
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cbang/db
  )
endif()
