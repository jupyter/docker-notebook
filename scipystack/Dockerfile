FROM ipython/ipython

MAINTAINER IPython Project <ipython-dev@scipy.org>

RUN apt-get -y update
RUN apt-get -y install git-core build-essential gfortran python3-dev curl

WORKDIR /tmp

# From https://github.com/ogrisel/docker-openblas
ADD config/openblas.conf /etc/ld.so.conf.d/openblas.conf
RUN git clone -q --branch=master git://github.com/xianyi/OpenBLAS.git
RUN /bin/bash -l -c "cd OpenBLAS && make DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32 && make install"
RUN ldconfig

RUN apt-get build-dep -y python3 python3-numpy python3-scipy python3-matplotlib cython3 python3-h5py
RUN apt-get install -y build-essential python3-dev

# From https://github.com/ogrisel/docker-sklearn-openblas
RUN git clone -q --branch=v1.9.0 git://github.com/numpy/numpy.git
ADD config/numpy-site.cfg /tmp/numpy/site.cfg
RUN /bin/bash -l -c "cd numpy && python2 setup.py install"
RUN /bin/bash -l -c "cd numpy && python3 setup.py install"

RUN git clone -q --branch=v0.14.0 git://github.com/scipy/scipy.git
ADD config/scipy-site.cfg /tmp/scipy/site.cfg
RUN /bin/bash -l -c "cd scipy && python2 setup.py install"
RUN /bin/bash -l -c "cd scipy && python3 setup.py install"

RUN pip2 install cython && pip3 install cython
RUN pip2 install pandas scikit-learn && pip3 install pandas scikit-learn
RUN pip2 install matplotlib && pip3 install matplotlib
RUN pip2 install seaborn && pip3 install seaborn
RUN pip2 install h5py && pip3 install h5py
RUN pip2 install yt && pip3 install yt
RUN pip2 install sympy && pip3 install sympy
RUN pip2 install patsy && pip3 install patsy
RUN pip2 install ggplot && pip3 install ggplot
RUN pip2 install statsmodels && pip3 install statsmodels

RUN python2 -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, yt, patsy, sympy, IPython, statsmodels"
RUN python3 -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, yt, patsy, sympy, IPython"

RUN apt-get autoremove -y
RUN apt-get clean -y
RUN rm -rf OpenBLAS numpy scipy
