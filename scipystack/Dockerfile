FROM ipython/base

MAINTAINER IPython Project <ipython-dev@scipy.org>
 
RUN apt-get build-dep -y python python-scipy python-matplotlib cython python-h5py && \
  easy_install -U distribute && \
  pip install -U Cython && \
  pip install numpy scipy pandas matplotlib scikit-learn && \
  pip install patsy && \
  pip install statsmodels && \
  pip install seaborn && \
  pip install yt && \
  pip install sympy && \
  pip install h5py

# Extremely basic test of install
RUN python -c "import matplotlib, scipy, numpy, pandas"
RUN python -c "import sklearn, seaborn, statsmodels, yt, patsy, sympy"
