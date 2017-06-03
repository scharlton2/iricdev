#!/bin/sh

if [ -z $GENERATOR ]; then
  echo "No Generator has been set"
  exit 1
fi

. ./versions.sh
VER=$CGNSLIB_VER

rm -rf lib/src/cgnslib-$VER
rd -rf lib/build/cgnslib-$VER
rd -rf lib/install/cgnslib-$VER

mkdir -p lib/src
cd lib/src
tar xvzf ../../cgnslib_$VER.tar.gz
mv cgnslib_$VER cgnslib-$VER
cd ../..

ctest -S build-cgnslib.cmake -DCONF_DIR:STRING=debug   -DCTEST_CMAKE_GENERATOR:STRING="Unix Makefiles" -C Debug   -V -O $SGEN-cgnslib-debug.log

ctest -S build-cgnslib.cmake -DCONF_DIR:STRING=release -DCTEST_CMAKE_GENERATOR:STRING="Unix Makefiles" -C Release -V -O $SGEN-cgnslib-release.log
