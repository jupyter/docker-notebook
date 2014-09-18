FROM ipython/geospatialstack

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

##VOLUME /notebooks
##WORKDIR /notebooks

##EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD Dont make this your default

#ADD geonotebook.sh /
#RUN chmod u+x /geonotebook.sh

#CMD ["/geonotebook.sh"]


EXPOSE 8888

ADD geonotebook.sh /usr/local/bin/geonotebook.sh
RUN chmod a+x /usr/local/bin/geonotebook.sh

# jupyter is our user
RUN useradd -m -s /bin/bash jupyter

USER jupyter
ENV HOME /home/jupyter
ENV SHELL /bin/bash
ENV USER jupyter

WORKDIR /home/jupyter/

ADD Welcome.ipynb /home/jupyter/
RUN cp -r /srv/ipython/examples /home/jupyter/examples

CMD ["/usr/local/bin/geonotebook.sh"]