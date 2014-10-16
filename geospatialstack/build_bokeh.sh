#!/usr/bin/env bash

set -xe
apt-get -y update

ln -s /usr/bin/nodejs /usr/bin/node

apt-get install -y node npm

git clone https://github.com/continuumio/bokeh
cd bokeh/bokehjs
npm install
cd ../
for PYTHONVER in 2 3 ; do
    PYTHON="python$PYTHONVER"
    $PYTHON setup.py install --build_js
  rm -rf build
done