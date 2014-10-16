#!/usr/bin/env bash

# Build GDAL and clean up build dependencies
set -xe

mkdir -p /tmp/build
cd /tmp/build

apt-get -y update

# System dependencies
apt-get build-dep -y gdal
apt-get install -y wget subversion libspatialindex-dev libpoppler-dev libpodofo-dev libopenjpeg-dev libwebp-dev libarmadillo-dev
apt-get install -y gdal-bin dans-gdal-scripts libgdal-dev libgdal1-dev libgdal-doc python-gdal python3-gdal libgrib-api-dev libgrib-api-tools python-grib python3-grib libspatialite-dev python-pyspatialite spatialite-bin

apt-get install -y node npm
#ln -s /usr/bin/nodejs /usr/bin/node

# Reduce the image size
apt-get autoremove -y
apt-get clean -y

cd /
rm -rf /tmp/build