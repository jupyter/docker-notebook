FROM ipython/scipystack

MAINTAINER IPython Project <ipython-dev@scipy.org>

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
ENV PASSWORD Dont make this your default

ADD ../notebook.sh /
RUN chmod u+x /notebook.sh

CMD /notebook.sh
