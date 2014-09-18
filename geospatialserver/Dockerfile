FROM ipython/geospatialstack

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD Dont make this your default

ADD geonotebook.sh /
RUN chmod u+x /geonotebook.sh

CMD ["/geonotebook.sh"]
