# Using the base IPython image
FROM ipython/base

MAINTAINER IPython Project <ipython-dev@scipy.org>
 
# Make sure apt is up to date
RUN apt-get update
RUN apt-get upgrade -y
 
RUN apt-get install -y liblapack-dev libatlas-base-dev gfortran libfreetype6-dev libpng12-dev && \
  easy_install -U distribute && \
  pip install -U Cython && \
  pip install numpy scipy pandas matplotlib scikit-learn && \
  pip install patsy && \
  pip install statsmodels && \
  pip install seaborn && \
  pip install yt && \
  apt-get clean -y

# Extremely basic test of install
RUN ipython -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, yt"
