FROM ipython/ipython

MAINTAINER IPython Project <ipython-dev@scipy.org>

RUN apt-get -y install git-core gfortran

WORKDIR /tmp

# From https://github.com/ogrisel/docker-openblas
ADD config/openblas.conf /etc/ld.so.conf.d/openblas.conf
RUN git clone -q --branch=master git://github.com/xianyi/OpenBLAS.git && \
    cd OpenBLAS && \
    make DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32 && \
    make install && \
    ldconfig && \
    rm -rf /tmp/OpenBLAS

RUN apt-get build-dep -y python3 python3-numpy python3-scipy python3-matplotlib cython3 python3-h5py && \
    apt-get autoremove -y && \
    apt-get clean -y

# From https://github.com/ogrisel/docker-sklearn-openblas
ADD config/numpy-site.cfg /tmp/numpy-site.cfg
RUN git clone -q --branch=v1.9.0 git://github.com/numpy/numpy.git && \
    cd numpy && \
    mv ../numpy-site.cfg site.cfg && \
    python2 setup.py install && \
    python3 setup.py install && \
    rm -rf /tmp/numpy

ADD config/scipy-site.cfg /tmp/scipy-site.cfg
RUN git clone -q --branch=v0.14.0 git://github.com/scipy/scipy.git && \
    cd scipy && \
    mv ../scipy-site.cfg site.cfg && \
    python2 setup.py install && \
    python3 setup.py install && \
    rm -rf /tmp/scipy

RUN pip2 install cython pandas scikit-learn matplotlib seaborn h5py yt sympy patsy ggplot statsmodels
RUN pip3 install cython pandas scikit-learn matplotlib seaborn h5py yt sympy patsy ggplot statsmodels

RUN python2 -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, yt, patsy, sympy, IPython, statsmodels"
RUN python3 -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, yt, patsy, sympy, IPython"
