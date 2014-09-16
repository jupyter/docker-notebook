FROM ubuntu:14.04

MAINTAINER IPython Project <ipython-dev@scipy.org>

# Make sure apt is up to date
RUN apt-get update
RUN apt-get upgrade -y

# Not essential, but wise to set the lang
# gives an error in finding the language-pack-en .deb
#RUN apt-get install -y language-pack-en
#ENV LANGUAGE en_US.UTF-8
#ENV LANG en_US.UTF-8
#ENV LC_ALL en_US.UTF-8

#RUN locale-gen en_US.UTF-8
#RUN dpkg-reconfigure locales

# Python binary dependencies, developer tools
RUN apt-get install -y -q build-essential make gcc zlib1g-dev git python3 python3-dev python3-pip && \
    apt-get install -y -q libzmq3-dev sqlite3 libsqlite3-dev pandoc libcurl4-openssl-dev nodejs

# Install Python 2.x as well
RUN apt-get install -y -q python python-dev python-pip

# Install IPython for Python 3 and 2
# Let IPython for Python 2 win as the default `ipython`
RUN pip3 install ipython[all]
RUN pip2 install ipython[all]

# Register each kernel
# This will be applied when IPython 3.0 comes out
#RUN ipython2 kernelspec install-self
#RUN ipython3 kernelspec install-self
