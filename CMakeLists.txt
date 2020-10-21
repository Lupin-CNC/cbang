cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)
project(Cbang)
list(APPEND CMAKE_MODULE_PATH "${${PROJECT_NAME}_SOURCE_DIR}/cmake")

option(CBANG_BACKTRACE "Enable backtrace support" ON)
option(CBANG_CHAKRA "Enable chakra-js support" OFF)
option(CBANG_LEVELDB "Enable LevelDB support" ON)
option(CBANG_OPENSSL "Enable OpenSSL support" ON)
option(CBANG_V8 "Enable v8-js support" OFF)
option(CBANG_VALGRIND "Enable valgrind support" OFF)

if(CBANG_CHAKRA AND CBANG_V8)
  message(FATAL_ERROR "Only one javascript backend can be enabled")
endif()

find_package(
  Boost
  REQUIRED
  date_time
  filesystem
  iostreams
  regex
)
find_package(BZip2 REQUIRED)
find_package(expat CONFIG REQUIRED)
find_package(Libevent CONFIG REQUIRED)
find_package(Libmysql REQUIRED)
find_package(lz4 CONFIG REQUIRED)

if(CBANG_LEVELDB)
  find_package(leveldb REQUIRED)
endif()

if(CBANG_OPENSSL)
  find_package(OpenSSL REQUIRED)
endif()

find_package(re2 CONFIG REQUIRED)
find_package(unofficial-sqlite3 CONFIG REQUIRED)
find_package(yaml CONFIG REQUIRED)

add_subdirectory(src)
