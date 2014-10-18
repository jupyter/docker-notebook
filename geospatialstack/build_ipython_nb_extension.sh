#!/usr/bin/env bash

set -xe

git clone https://github.com/ellisonbg/leafletwidget
cd leafletwidget
for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  if PYTHONVER==2 ; then
      pip2 install requests
  fi
  $PYTHON setup.py install
  $PYTHON install-nbextension.py
done