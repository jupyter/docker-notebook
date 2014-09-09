#!/usr/bin/env bash

# Build OpenBLAS and clean up build dependencies
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
apt-get build-dep -y python3 python3-numpy python3-scipy python3-matplotlib cython3 python3-h5py
apt-get install -y build-essential python3-dev
curl https://bootstrap.pypa.io/get-pip.py | python3
pip3 install cython

# Build NumPy and SciPy from source against OpenBLAS installed
git clone -q --branch=v1.9.0 git://github.com/numpy/numpy.git
cp /numpy-site.cfg numpy/site.cfg
(cd numpy && python3 setup.py install)

git clone -q --branch=v0.14.0 git://github.com/scipy/scipy.git
cp /scipy-site.cfg scipy/site.cfg
(cd scipy && python3 setup.py install)

pip3 install pandas scikit-learn
pip3 install matplotlib
pip3 install seaborn
pip3 install h5py
pip3 install yt
pip3 install sympy
pip3 install patsy

# Reduce the image size
apt-get autoremove -y
apt-get clean -y

cd /
rm -rf /tmp/build
rm -rf /build_openblas.sh
