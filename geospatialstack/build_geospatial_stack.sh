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
apt-get install -y wget subversion libspatialindex-dev

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
cd ..


wget --no-check-certificate https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.9.16.tar.gz
tar -xvf grib_api-1.9.16.tar.gz
cd grib_api-1.9.16
export CFLAGS="-O2 -fPIC"
./configure --enable-python
make
sudo make install

echo /usr/local/lib/python2.7/site-packages/grib_api > gribapi.pth
sudo cp gribapi.pth /usr/local/lib/python2.7/dist-packages/

#echo /usr/local/lib/python3.4/site-packages/grib_api > gribapi.pth
#sudo cp gribapi.pth /usr/local/lib/python3.4/dist-packages/

cd ..

for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  PIP="pip$PYTHONVER"

  # A first Stack of geospatial libraries
  $PIP install -U setuptools
  $PIP install -U pyproj
  $PIP install -U git+https://github.com/Toblerity/Shapely 
  $PIP install -U git+https://github.com/Toblerity/Fiona
  $PIP install -U git+https://github.com/geopandas/geopandas
  $PIP install -U git+https://github.com/mpld3/mplexporter
  $PIP install -U git+https://github.com/jwass/mplleaflet
  $PIP install -U geojson
  $PIP install -U patsy
  $PIP install -U mock
  $PIP install -U pyshp
  $PIP install -U git+https://github.com/SciTools/cartopy
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

# to  do
#mpl_toolkits.basemap 

echo "installing geos & basemap"
wget --no-check-certificate -c --progress=dot:mega http://softlayer-dal.dl.sourceforge.net/project/matplotlib/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz
tar -zxf basemap-1.0.7.tar.gz
cd basemap-1.0.7
cd geos-3.3.3
export GEOS_DIR=$PREFIX/local/geos
./configure --prefix=$GEOS_DIR
make -j $np
make install
make distclean > /dev/null 2>&1
cd ..
for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  $PYTHON setup.py install
  rm -rf build
done


# Reduce the image size
apt-get autoremove -y
apt-get clean -y

cd /
rm -rf /tmp/build
