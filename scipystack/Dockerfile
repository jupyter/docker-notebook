# Using the base IPython image
FROM ipython/base

MAINTAINER IPython Project <ipython-dev@scipy.org>
 
# Make sure apt is up to date
RUN apt-get update
RUN apt-get upgrade -y
 
# Not essential, but wise to set the lang
RUN apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
 
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# Python binary dependencies, developer tools
RUN apt-get install -y -q build-essential make gcc zlib1g-dev git python python-dev python-pip && \
    apt-get install -y -q libzmq3-dev sqlite3 libsqlite3-dev pandoc libcurl4-openssl-dev nodejs && \
    apt-get autoremove -y --purge && \
    apt-get clean -y

RUN apt-get install -y liblapack-dev libatlas-base-dev gfortran libfreetype6-dev libpng12-dev && \
  easy_install -U distribute && \
  pip install -U Cython && \
  pip install numpy scipy pandas matplotlib scikit-learn && \
  pip install patsy && \
  pip install statsmodels && \
  pip install seaborn && \
  pip install yt && \
  apt-get remove -y --purge libatlas-base-dev gfortran && \
  apt-get autoremove -y --purge && \
  apt-get clean -y
