FROM ipython/base

MAINTAINER IPython Project <ipython-dev@scipy.org>

ADD notebook.sh /usr/local/bin/notebook.sh

RUN chmod a+rx /usr/local/bin/notebook.sh

RUN useradd -m -s /bin/bash jupyter

USER jupyter
ENV HOME /home/jupyter
ENV SHELL /bin/bash
ENV USER jupyter
ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

WORKDIR /home/jupyter/

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /home/jupyter/key.pem

# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD DontKeepTheDefault

EXPOSE 8888

CMD ["/usr/local/bin/notebook.sh"]
