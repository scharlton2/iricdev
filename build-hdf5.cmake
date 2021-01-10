set(CTEST_BUILD_NAME "$ENV{SGEN}-hdf5")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

set(VER "$ENV{HDF5_VER}")
set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/hdf5-${VER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/build/hdf5-${VER}")

set(BUILD_OPTIONS 
-C${CTEST_SOURCE_DIRECTORY}/config/cmake/cacheinit.cmake
-DBUILD_TESTING:BOOL=OFF
-DHDF5_BUILD_TOOLS:BOOL=$ENV{BUILD_TOOLS}
-DMSVC12_REDIST_DIR:PATH=C:/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 12.0/VC/redist
-DBUILD_SHARED_LIBS:BOOL=ON
-DHDF5_PACKAGE_EXTLIBS:BOOL=ON
-DHDF5_ENABLE_Z_LIB_SUPPORT:BOOL=ON
-DHDF5_ENABLE_SZIP_SUPPORT:BOOL=ON
-DHDF5_BUILD_HL_LIB:BOOL=ON
-DHDF5_BUILD_CPP_LIB:BOOL=OFF
-DHDF5_BUILD_FORTRAN:BOOL=OFF
-DHDF5_BUILD_EXAMPLES:BOOL=OFF
-DHDF5_ALLOW_EXTERNAL_SUPPORT:STRING=TGZ
-DTGZPATH:PATH=${CTEST_SCRIPT_DIRECTORY}
)

if("${CONF_DIR}" STREQUAL "debug")
  list(APPEND BUILD_OPTIONS "-DCMAKE_BUILD_TYPE:STRING=Debug")
else()
  list(APPEND BUILD_OPTIONS "-DCMAKE_BUILD_TYPE:STRING=Release")
endif()

CTEST_START("Experimental")
CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
# for hdf we build PACKAGE target instead of INSTALL target
# since the szip and zlib libraries cmake configurations
# are created only during the packaging stage
# see lib/install/hdf5-${VER}/${CONF_DIR}/cmake
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET package)

if (WIN32)
  file(COPY "${CTEST_BINARY_DIRECTORY}/_CPack_Packages/win64/TGZ/HDF5-${VER}-win64/"
    DESTINATION "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${VER}/${CONF_DIR}")
endif()

if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  file(COPY "${CTEST_BINARY_DIRECTORY}/_CPack_Packages/Linux/TGZ/HDF5-${VER}-Linux/HDF_Group/HDF5/${VER}/"
    DESTINATION "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${VER}/${CONF_DIR}")
endif()