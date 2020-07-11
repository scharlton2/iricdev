set(CTEST_PROJECT_NAME "yaml-cpp")
set(CTEST_BUILD_NAME "$ENV{SGEN}-yaml-cpp")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

set(VER   "$ENV{YAML_CPP_VER}")
set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/yaml-cpp-${VER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/build/yaml-cpp-${VER}/${CONF_DIR}")

set(BUILD_OPTIONS 
-DYAML_BUILD_SHARED_LIBS:BOOL=ON
-DCMAKE_INSTALL_PREFIX:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/yaml-cpp-${VER}/${CONF_DIR}
-DYAML_CPP_BUILD_TESTS:BOOL=OFF
)

CTEST_START("Experimental")
CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET install)