FROM ipython/base

MAINTAINER IPython Project <ipython-dev@scipy.org>
 
RUN apt-get build-dep -y python python-scipy python-matplotlib cython && \
  easy_install -U distribute && \
  pip install -U Cython && \
  pip install numpy scipy pandas matplotlib scikit-learn && \
  pip install patsy && \
  pip install statsmodels && \
  pip install seaborn && \
  pip install yt && \
  apt-get clean -y

# Extremely basic test of install
RUN python -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, statsmodels, yt, patsy"
