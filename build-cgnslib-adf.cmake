set(CTEST_PROJECT_NAME "cgns")
set(CTEST_BUILD_NAME "$ENV{SGEN}-cgns")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

set(VER "$ENV{CGNSLIB_VER}")
if(WIN32 AND "${VER}" STREQUAL "3.2.1")
  set(VER "$ENV{CGNSLIB_VER}-patch1")
endif()
set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/build/cgnslib-adf-${VER}/${CONF_DIR}")

if (WIN32)
  if("${CONF_DIR}" STREQUAL "release")
    # HACK to force extract_subset.c to compile (fails w/ VS2013 Release build)
    file(RENAME
      ${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}/src/cgnstools/utilities/extract_subset.c
      ${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}/src/cgnstools/utilities/extract_subset.c.orig
    )
    file(WRITE
      ${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}/src/cgnstools/utilities/extract_subset.c
      "int main(int argc, char *argv[]) { return 0; }\n"
    )
  endif()
endif()

set(BUILD_OPTIONS 
-DCMAKE_INSTALL_PREFIX:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-adf-${VER}/${CONF_DIR}
-DCGNS_BUILD_CGNSTOOLS:BOOL=$ENV{BUILD_TOOLS}
-DCGNS_ENABLE_FORTRAN:BOOL=ON
-DCGNS_ENABLE_HDF5:BOOL=OFF
-DCGNS_ENABLE_LFS:BOOL=ON
)

if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  list(APPEND BUILD_OPTIONS "-DCMAKE_C_FLAGS:STRING=-D_LARGEFILE64_SOURCE")
endif()

CTEST_START("Experimental")
CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET install)


if($ENV{BUILD_TOOLS} MATCHES "[Oo][Nn]" AND "${CONF_DIR}" STREQUAL "release")
  if (WIN32)
    # restore original extract_subset.c
    file(REMOVE
      ${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}/src/cgnstools/utilities/extract_subset.c
    )
    file(RENAME
      ${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}/src/cgnstools/utilities/extract_subset.c.orig
      ${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}/src/cgnstools/utilities/extract_subset.c
    )
    # delete fake extract_subset.exe
    file(REMOVE
      ${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-adf-${VER}/${CONF_DIR}/bin/extract_subset.exe
    )
    # write note about extract-subset.exe
    file(WRITE
      ${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-adf-${VER}/${CONF_DIR}/bin/extract_subset.exe.txt
      "${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}/src/cgnstools/utilities/extract_subset.c causes an internal compiler error in VS2013 Release. (see ${CTEST_SCRIPT_DIRECTORY}/build-cgnslib-adf.cmake.\n"
    )
  endif()
endif()
