# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
Findmysql
-------

Finds the mysql library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``libmysql``
  The mysql library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``LIBMYSQL_FOUND``
  True if the system has the mysql library.
``LIBMYSQL_VERSION``
  The version of the mysql library which was found.
``LIBMYSQL_INCLUDE_DIRS``
  Include directories needed to use mysql.
``LIBMYSQL_LIBRARIES``
  Libraries needed to link to mysql.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``LIBMYSQL_INCLUDE_DIR``
  The directory containing ``mysql.h``.
``LIBMYSQL_LIBRARY``
  The path to the mysql library.

#]=======================================================================]

find_package(PkgConfig)
pkg_check_modules(PC_mysql QUIET "libmysql")

if(NOT PC_LIBMYSQL_FOUND)
  pkg_check_modules(PC_mysql QUIET "mysql")
endif(NOT PC_LIBMYSQL_FOUND)

find_path(LIBMYSQL_INCLUDE_DIR NAMES mysql.h mysql/mysql.h PATHS ${PC_mysql_INCLUDE_DIRS})
find_library(LIBMYSQL_LIBRARY NAMES libmysql mysql mysqlclient PATHS ${PC_mysql_LIBRARY_DIRS})

set(LIBMYSQL_VERSION ${PC_mysql_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  ${CMAKE_FIND_PACKAGE_NAME}
  FOUND_VAR
  LIBMYSQL_FOUND
  REQUIRED_VARS
  LIBMYSQL_LIBRARY
  LIBMYSQL_INCLUDE_DIR
  VERSION_VAR
  LIBMYSQL_VERSION
)

if(LIBMYSQL_FOUND)
  set(LIBMYSQL_LIBRARIES ${LIBMYSQL_LIBRARY})
  set(LIBMYSQL_INCLUDE_DIRS ${LIBMYSQL_INCLUDE_DIR})
  set(LIBMYSQL_DEFINITIONS ${PC_mysql_CFLAGS_OTHER})
endif()

if(LIBMYSQL_FOUND AND NOT TARGET mysql)
  add_library(libmysql UNKNOWN IMPORTED)
  set_target_properties(
    libmysql
    PROPERTIES
      IMPORTED_LOCATION
      "${LIBMYSQL_LIBRARY}"
      INTERFACE_COMPILE_OPTIONS
      "${PC_mysql_CFLAGS_OTHER}"
      INTERFACE_INCLUDE_DIRECTORIES
      "${LIBMYSQL_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(LIBMYSQL_INCLUDE_DIR LIBMYSQL_LIBRARY)
