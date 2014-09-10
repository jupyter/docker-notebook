FROM ipython/base

MAINTAINER IPython Project <ipython-dev@scipy.org>

# From https://github.com/ogrisel/docker-openblas
ADD openblas.conf /etc/ld.so.conf.d/openblas.conf

# From https://github.com/ogrisel/docker-sklearn-openblas
ADD numpy-site.cfg numpy-site.cfg
ADD scipy-site.cfg scipy-site.cfg

ADD build_scipy_stack.sh build_scipy_stack.sh
RUN bash build_scipy_stack.sh

## Extremely basic test of install
RUN python3 -c "import matplotlib, scipy, numpy, pandas"
RUN python3 -c "import sklearn, seaborn, yt, patsy, sympy"
