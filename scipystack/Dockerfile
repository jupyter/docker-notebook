FROM ipython/ipython:3.x

MAINTAINER IPython Project <ipython-dev@scipy.org>

# From https://github.com/ogrisel/docker-openblas
ADD openblas.conf /etc/ld.so.conf.d/openblas.conf

# From https://github.com/ogrisel/docker-sklearn-openblas
ADD numpy-site.cfg /tmp/numpy-site.cfg
ADD scipy-site.cfg /tmp/scipy-site.cfg

ADD build_scipy_stack.sh /tmp/build_scipy_stack.sh
RUN bash /tmp/build_scipy_stack.sh

## Extremely basic test of install
RUN python2 -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, yt, patsy, sympy, IPython, statsmodels"
RUN python3 -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, yt, patsy, sympy, IPython"

# Clean up from build
RUN rm -f /tmp/build_scipy_stack.sh /tmp/numpy-site.cfg /tmp/scipy-site.cfg
