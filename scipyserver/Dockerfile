FROM ipython/scipystack

MAINTAINER IPython Project <ipython-dev@scipy.org>

ADD notebook.sh /usr/local/bin/notebook.sh

RUN chmod a+rx /usr/local/bin/notebook.sh

RUN useradd -m -s /bin/bash ipynb

USER ipynb
ENV HOME /home/ipynb
ENV SHELL /bin/bash
ENV USER ipynb

WORKDIR /home/ipynb/

RUN mkdir -p /home/ipynb/.config/matplotlib/
ADD matplotlibrc /home/ipynb/.config/matplotlib/matplotlibrc

# You can mount your own SSL certs as necessary here
ENV PEM_FILE ~/key.pem

# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD DontKeepTheDefault

EXPOSE 8888

CMD ["/usr/local/bin/notebook.sh"]
