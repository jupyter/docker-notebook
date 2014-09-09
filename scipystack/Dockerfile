FROM ipython/base

MAINTAINER IPython Project <ipython-dev@scipy.org>

RUN apt-get build-dep -y python3 python3-scipy python3-matplotlib cython3 python3-h5py && \
  pip3 install -U Cython && \
  pip3 install numpy scipy pandas matplotlib scikit-learn && \
  pip3 install patsy && \
  pip3 install statsmodels && \
  pip3 install seaborn && \
  pip3 install yt && \
  pip3 install sympy && \
  pip3 install h5py

# Extremely basic test of install
RUN python3 -c "import matplotlib, scipy, numpy, pandas"
RUN python3 -c "import sklearn, seaborn, statsmodels, yt, patsy, sympy"
