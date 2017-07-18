@echo off
REM
REM download.cmd
REM
REM requires wget available from http://gnuwin32.sourceforge.net/packages/wget.htm
REM
REM wget --no-check-certificate http://download.qt.io/official_releases/online_installers/qt-unified-windows-x86-online.exe
REM wget --no-check-certificate https://my.visualstudio.com/Downloads?pid=1901
REM wget --no-check-certificate https://cmake.org/files/v3.8/cmake-3.8.0-win64-x64.msi
REM wget --no-check-certificate http://prdownloads.sourceforge.net/nsis/nsis-3.01-setup.exe
REM
setlocal enableextensions enabledelayedexpansion
call versions.cmd
IF NOT EXIST "VTK-%VTK-VER%.zip" (
  REM pull off major and minor version (must use enabledelayedexpansion with exclamation points to work)
  for /f "tokens=1,2 delims=." %%a in ("%VTK-VER%") do set MAJOR.MINOR=%%a.%%b
  wget --no-check-certificate http://www.vtk.org/files/release/!MAJOR.MINOR!/VTK-%VTK-VER%.zip
)
IF NOT EXIST "hdf5-%HDF5-VER%.zip" (
  for /f "tokens=1,2 delims=." %%a in ("%HDF5-VER%") do set MAJOR.MINOR=%%a.%%b
  wget ftp://ftp.hdfgroup.org/HDF5/releases/hdf5-!MAJOR.MINOR!/hdf5-%HDF5-VER%/cmake/SZip.tar.gz
  wget ftp://ftp.hdfgroup.org/HDF5/releases/hdf5-!MAJOR.MINOR!/hdf5-%HDF5-VER%/cmake/ZLib.tar.gz
  wget ftp://ftp.hdfgroup.org/HDF5/releases/hdf5-!MAJOR.MINOR!/hdf5-%HDF5-VER%/src/hdf5-%HDF5-VER%.zip
)
IF NOT EXIST "cgnslib_%CGNSLIB-VER%.tar.gz" (
  wget --no-check-certificate https://downloads.sourceforge.net/project/cgns/cgnslib_3.2/cgnslib_%CGNSLIB-VER%.tar.gz
)
IF NOT EXIST "iriclib-%IRICLIB_VER:~0,7%.zip" (
  wget --no-check-certificate https://github.com/i-RIC/iriclib/archive/%IRICLIB_VER%.zip --output-document=iriclib-%IRICLIB_VER:~0,7%.zip
)
IF NOT EXIST "shapelib-%SHAPELIB-VER%.zip" (
  wget --no-check-certificate http://download.osgeo.org/shapelib/shapelib-%SHAPELIB-VER%.zip
)
IF NOT EXIST "qwt-%QWT-VER%.zip" (
  wget --no-check-certificate https://sourceforge.net/projects/qwt/files/qwt/%QWT-VER%/qwt-%QWT-VER%.zip/download
)
IF NOT EXIST "gdal-%GDAL-VER%.tar.gz" (
  wget --no-check-certificate http://download.osgeo.org/gdal/%GDAL-VER%/gdal-%GDAL-VER%.tar.gz
)
IF NOT EXIST "proj-%PROJ-VER%.zip" (
  wget --no-check-certificate http://download.osgeo.org/proj/proj-%PROJ-VER%.zip
)
IF NOT EXIST "netcdf-%NETCDF-VER%.zip" (
  wget --no-check-certificate ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-%NETCDF-VER%.zip
)
IF NOT EXIST "geos-%GEOS-VER%.tar.bz2" (
  wget --no-check-certificate http://download.osgeo.org/geos/geos-%GEOS-VER%.tar.bz2
)
IF NOT EXIST "boost_%BOOST_UVER%.7z" (
  wget --no-check-certificate https://sourceforge.net/projects/boost/files/boost/%BOOST-VER%/boost_%BOOST_UVER%.7z/download
)
IF NOT EXIST "yaml-cpp-release-%YAML-CPP-VER%.zip" (
  wget --no-check-certificate https://github.com/jbeder/yaml-cpp/archive/release-%YAML-CPP-VER%.zip --output-document=yaml-cpp-release-%YAML-CPP-VER%.zip
)


endlocal
