FROM ipython/base

MAINTAINER IPython Project <ipython-dev@scipy.org>

# From https://github.com/ogrisel/docker-openblas
ADD https://raw.githubusercontent.com/ogrisel/docker-openblas/master/openblas.conf /etc/ld.so.conf.d/openblas.conf

# From https://github.com/ogrisel/docker-sklearn-openblas
ADD https://raw.githubusercontent.com/ogrisel/docker-sklearn-openblas/master/numpy-site.cfg numpy-site.cfg
ADD https://raw.githubusercontent.com/ogrisel/docker-sklearn-openblas/master/scipy-site.cfg scipy-site.cfg
ADD https://raw.githubusercontent.com/ogrisel/docker-sklearn-openblas/master/build_sklearn.sh build_sklearn.sh

ADD build_scipy_stack.sh build_scipy_stack.sh
RUN bash build_scipy_stack.sh

## Extremely basic test of install
RUN python3 -c "import matplotlib, scipy, numpy, pandas"
RUN python3 -c "import sklearn, seaborn, yt, patsy, sympy"
