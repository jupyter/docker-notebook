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
apt-get install -y wget subversion libspatialindex-dev libpoppler-dev libpodofo-dev libopenjpeg-dev libwebp-dev libarmadillo-dev
apt-get install -y gdal-bin dans-gdal-scripts libgdal-dev libgdal1-dev libgdal-doc python-gdal python3-gdal libgrib-api-dev libgrib-api-tools python-grib python3-grib python-mpltoolkits.basemap libspatialite-dev python-pyspatialite spatialite-bin