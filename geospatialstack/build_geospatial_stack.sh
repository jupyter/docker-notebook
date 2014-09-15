#!/usr/bin/env bash

# Build GDAL and clean up build dependencies
set -xe

mkdir /tmp/build
cd /tmp/build

apt-get -y update
apt-get -y install git-core build-essential gfortran python3-dev curl

# Build latest stable release from OpenBLAS from source
git clone -q --branch=master git://github.com/xianyi/OpenBLAS.git
(cd OpenBLAS \
      && make DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32 \
          && make install)

# Rebuild ld cache, this assumes that:
# /etc/ld.so.conf.d/openblas.conf was installed by Dockerfile
# and that the libraries are in /opt/OpenBLAS/lib
ldconfig

# System dependencies
apt-get build-dep -y gdal
apt-get install -y wget subversion

PREFIX="/usr"
wget --no-check-certificate -c --progress=dot:mega http://download.osgeo.org/gdal/1.11.0/gdal-1.11.0.tar.gz
tar -zxf gdal-1.11.0.tar.gz
cd gdal-1.11.0
for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
#--with-pg=$PREFIX/bin/pg_config
CPPFLAGS=-I$PREFIX/include ./configure --with-hdf5=$PREFIX/  --with-hdf4=$PREFIX/ --with-hdf4=/usr --with-geos=$PREFIX/bin/geos-config --with-spatialite=$PREFIX/ --with-freexl=$PREFIX/ --with-python=$PYTHON --with-pg=$PREFIX/bin/pg_config --prefix=$PREFIX/ --with-netcdf=$PREFIX/
make -j $np
make install
make distclean > /dev/null 2>&1
done


for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  PIP="pip$PYTHONVER"

  # Build NumPy and SciPy from source against OpenBLAS installed
  (cd numpy && $PYTHON setup.py install)
  (cd scipy && $PYTHON setup.py install)
  
  # The rest of the SciPy Stack
  $PIP install pyproj
  $PIP install shapely 
  $PIP install fiona
  $PIP install geopandas
  $PIP install mplexporter
  $PIP install mplleaflet
  $PIP install geojson
  $PIP install patsy
done

svn checkout http://netcdf4-python.googlecode.com/svn/trunk/ netcdf4-python
cd netcdf4-python
export HDF5_DIR=$PREFIX/
export NETCDF4_DIR=$PREFIX/
for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  $PYTHON setup.py install
  rm -rf build
done

# todo
#mpl_toolkits.basemap 

# Reduce the image size
apt-get autoremove -y
apt-get clean -y

cd /
rm -rf /tmp/build
