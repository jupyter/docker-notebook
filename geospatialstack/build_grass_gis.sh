#!/usr/bin/env bash

set -xe

mkdir /tmp/build

cd /tmp/build

apt-get -y update

np=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

ldconfig

PREFIX="/usr"

echo "installing grass"
apt-get build-dep -y grass
svn -q checkout https://svn.osgeo.org/grass/grass/trunk grass7_trunk
cd grass7_trunk

sed '44d' Makefile >> Makefile.new
rm -rf Makefile
mv Makefile.new Makefile

#LD_LIBRARY_PATH=$PREFIX/lib/ CPPFLAGS=-I$PREFIX/include LDFLAGS=-L$PREFIX/lib ./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=$PREFIX/bin/geos-config --with-netcdf=$PREFIX/bin/nc-config --with-proj-data=$PREFIX/share/proj/ --with-postgres=yes --with-sqlite --with-pthread --with-readline --with-lapack --with-blas --with-proj-includes=$PREFIX/include --with-proj-data=$PREFIX/share/ --prefix=$PREFIX
#export LD_LIBRARY_PATH=$PREFIX/lib/
# --with-postgres=yes --with-postgres-includes=$PREFIX/include/ --with-postgres-libs=$PREFIX/lib
./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=/opt/geos/bin/geos-config --with-netcdf=/usr/bin/nc-config --with-proj-share=/usr/share/proj --with-sqlite --with-pthread --with-readline=yes --with-lapack=yes --with-blas=yes --prefix=/opt/grass --with-proj-includes=$PREFIX/include/ --with-proj-libs=$PREFIX/lib --without-wxwidget

make -j $np
make install

# Reduce the image size
apt-get autoremove -y
apt-get clean -y

cd /
rm -rf /tmp/build