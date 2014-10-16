#!/usr/bin/env bash

set -xe

mkdir -p /tmp/build

cd /tmp/build

apt-get -y update

np=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

ldconfig

PREFIX="/usr"

for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  PIP="pip$PYTHONVER"

  # A first Stack of geospatial libraries
  $PIP install -U setuptools
  $PIP install -U pyproj
  $PIP install -U git+https://github.com/Toblerity/Shapely 
  #$PIP install -U git+https://github.com/Toblerity/Fiona
  $PIP install -U git+https://github.com/geopandas/geopandas
  $PIP install -U git+https://github.com/mpld3/mplexporter
  $PIP install -U geojson
  $PIP install -U mock
  $PIP install -U pyshp
  $PIP install -U git+https://github.com/SciTools/cartopy
  $PIP install -U numexpr
  export HDF5_DIR=$PREFIX/
  $PIP install -U tables
  $PIP install -U git+https://github.com/astropy/astropy
  $PIP install -U geopy
  $PIP install -U pyopengl
  $PIP install -U pillow
  $PIP install -U git+https://github.com/spectralpython/spectral.git
  $PIP install -U git+https://github.com/mapbox/rasterio
done

pip2 install -U pysal
pip2 install -U git+https://github.com/jwass/mplleaflet

svn checkout http://netcdf4-python.googlecode.com/svn/trunk/ netcdf4-python
cd netcdf4-python
export HDF5_DIR=$PREFIX/
export NETCDF4_DIR=$PREFIX/
for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  $PYTHON setup.py install
  rm -rf build
done

# ned to add the notebook js xtension

# Reduce the image size
apt-get autoremove -y
apt-get clean -y

cd /
rm -rf /tmp/build