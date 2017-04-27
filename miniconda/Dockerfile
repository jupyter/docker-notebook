FROM ipython/ipython

MAINTAINER IPython Project <ipython-dev@scipy.org>

RUN apt-get update && apt-get install -y bzip2 curl

RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/conda.sh

WORKDIR /tmp

RUN curl http://repo.continuum.io/miniconda/Miniconda3-3.7.3-Linux-x86_64.sh -o conda.sh && \
    /bin/bash conda.sh -b -p /opt/anaconda && \
    rm conda.sh

ENV PATH /opt/anaconda/bin:$PATH

WORKDIR /srv/ipython/

# Dependencies for the notebook and nbconvert
RUN conda install -y tornado sphinx pygments pexpect pyzmq jinja2 jsonschema

RUN /opt/anaconda/bin/python setup.py install
