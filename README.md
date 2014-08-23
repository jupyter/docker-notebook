IPython in Docker
=================

This repository contains the Dockerfiles and shell scripts used by four Docker
containers:

* [ipython/base](base) - Base installation of IPython and its dependencies
* [ipython/scipystack](scipystack) - Relies on `ipython/base`, installs the [scipy stack](http://www.scipy.org/stackspec.html) & more
* [ipython/scipyserver](scipyserver) - Relies on `ipython/scipystack`, sets up a notebook server. See the [README](scipyserver/README.md) for usage instructions.
* [ipython/notebook](notebook) - Relies on `ipython/base` and *just* sets up the IPython notebook. No additional Python packages are installed by default
