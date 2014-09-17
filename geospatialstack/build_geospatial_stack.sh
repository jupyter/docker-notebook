#!/usr/bin/env bash

# Build GDAL and clean up build dependencies
set -xe

mkdir /tmp/build
cd /tmp/build

apt-get -y update
apt-get -y install git-core build-essential gfortran python3-dev curl

np=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

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
apt-get install -y wget subversion libspatialindex-dev libpoppler-dev libpodofo-dev

PREFIX="/usr"

echo "installing geos & basemap"
wget --no-check-certificate -c --progress=dot:mega http://softlayer-dal.dl.sourceforge.net/project/matplotlib/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz
tar -zxf basemap-1.0.7.tar.gz
cd basemap-1.0.7
cd geos-3.3.3
export GEOS_DIR=/opt/geos
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

echo "installing freexl"
wget --no-check-certificate -c --progress=dot:mega http://www.gaia-gis.it/gaia-sins/freexl-sources/freexl-1.0.0g.tar.gz
tar -zxf freexl-1.0.0g.tar.gz
cd freexl-1.0.0g
./configure --prefix=/opt/freexl
make -j $np
make install



echo "installing libspatialite"
wget --no-check-certificate -c --progress=dot:mega http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-4.2.0.tar.gz
tar -zxf libspatialite-4.1.1.tar.gz
cd libspatialite-4.1.1
CPPFLAGS=-I$/opt/freexl/include/ LDFLAGS=-L$/opt/freexl/lib ./configure --with-geosconfig=/opt/geos/bin/geos-config --prefix=/opt/libspatialite
make -j $np
make install

GRIB_PREFIX=/opt/grib
wget --no-check-certificate https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.9.16.tar.gz
tar -xvf grib_api-1.9.16.tar.gz
cd grib_api-1.9.16
export CFLAGS="-O2 -fPIC"
./configure --enable-python --prefix=$GRIB_PREFIX
make
sudo make install

echo /opt/grib/lib/python2.7/site-packages/grib_api > gribapi.pth
sudo cp gribapi.pth /usr/local/lib/python2.7/dist-packages/

#echo /usr/local/lib/python3.4/site-packages/grib_api > gribapi.pth
#sudo cp gribapi.pth /usr/local/lib/python3.4/dist-packages/

cd ..

GDAL_PREFIX="/opt/gdal"
wget --no-check-certificate -c --progress=dot:mega http://download.osgeo.org/gdal/1.11.0/gdal-1.11.0.tar.gz
tar -zxf gdal-1.11.0.tar.gz
cd gdal-1.11.0
for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  #--with-pg=$PREFIX/bin/pg_config
  CPPFLAGS=-I$PREFIX/include ./configure --with-spatialite=/opt/libspatialite --with-hdf5=$PREFIX/  --with-hdf4=$PREFIX/ --with-geos=/opt/geos/bin/geos-config --with-spatialite=/opt/libspatialite --with-freexl=/opt/freexl --with-python=$PYTHON --prefix=$GDAL_PREFIX/ --with-netcdf=$PREFIX/
  make -j $np
  make install
  make distclean > /dev/null 2>&1
done
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
  $PIP install -U mock
  $PIP install -U pyshp
  $PIP install -U git+https://github.com/SciTools/cartopy
  export HDF5_DIR=$PREFIX/
  $PIP install -U tables
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



echo "installing grass"
apt-get build-dep -y grass
svn -q checkout https://svn.osgeo.org/grass/grass/trunk grass7_trunk
cd grass7_trunk 
#LD_LIBRARY_PATH=$PREFIX/lib/ CPPFLAGS=-I$PREFIX/include LDFLAGS=-L$PREFIX/lib ./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=$PREFIX/bin/geos-config --with-netcdf=$PREFIX/bin/nc-config --with-proj-data=$PREFIX/share/proj/ --with-postgres=yes --with-sqlite --with-pthread --with-readline --with-lapack --with-blas --with-proj-includes=$PREFIX/include --with-proj-data=$PREFIX/share/ --prefix=$PREFIX
#export LD_LIBRARY_PATH=$PREFIX/lib/
# --with-postgres=yes --with-postgres-includes=$PREFIX/include/ --with-postgres-libs=$PREFIX/lib
./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=/opt/geos/bin/geos-config --with-netcdf=/usr/bin/nc-config --with-proj-share=/usr/share/proj --with-sqlite --with-pthread --with-readline --with-lapack=/opt/blas --with-blas=/opt/blas --prefix=/opt/grass --with-proj-includes=$PREFIX/include/ --with-proj-libs=$PREFIX/lib 

make -j $np
make install

# Reduce the image size
apt-get autoremove -y
apt-get clean -y

cd /
rm -rf /tmp/build
