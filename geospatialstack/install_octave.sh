#!/usr/bin/env bash

set -xe


apt-get install -y octave octave-bim octave-communications octave-control octave-data-smoothing octave-dataframe octave-econometrics octave-epstk \
octave-financial octave-fpl octave-ga octave-general octave-geometry octave-gmt octave-gsl octave-image octave-io octave-linear-algebra \
octave-mapping octave-miscellaneous octave-missing-functions octave-mpi octave-nan octave-nlopt octave-nnet octave-nurbs \
octave-ocs octave-octcdf octave-octgpr octave-odepkg octave-optim octave-optiminterp octave-pkg-dev octave-plot octave-quaternion \
octave-signal octave-sockets octave-specfun octave-splines octave-statistics octave-strings octave-struct octave-sundials  octave-symbolic \
octave-tsa octave-vlfeat octave-vrml

for PYTHONVER in 2 3 ; do
  PIP="pip$PYTHONVER"
  $PIP install oct2py
done