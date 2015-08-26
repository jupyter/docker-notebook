IPython in Docker
=================

This repository contains the Dockerfiles and shell scripts used by four Docker
containers:

* [ipython/scipystack](scipystack) - Relies on `ipython/ipython`, installs the [scipy stack](http://www.scipy.org/stackspec.html) & more
* [ipython/scipyserver](scipyserver) - Relies on `ipython/scipystack`, sets up a notebook server. See the [README](scipyserver/README.md) for usage instructions.
* [ipython/notebook](notebook) - Relies on `ipython/ipython` and *just* sets up the IPython notebook. No additional Python packages are installed by default

In practice though, the most recent versions of [each of these images is up on the Docker Hub](https://hub.docker.com/u/ipython/).

Instructions for each are within the respective folders for each, but to get started with the scipystack image for example, run `docker run -it ipython/scipystack /bin/bash`:

```
$ docker run -it ipython/scipystack /bin/bash
root@10e02f441814:/# ipython
Python 3.4.0 (default, Apr 11 2014, 13:05:11)
Type "copyright", "credits" or "license" for more information.

IPython 2.2.0 -- An enhanced Interactive Python.
?         -> Introduction and overview of IPython's features.
%quickref -> Quick reference.
help      -> Python's own help system.
object?   -> Details about 'object', use 'object??' for extra details.

In [1]: import numpy as np

In [2]: np.linspace(2,10)
Out[2]:
array([  2.        ,   2.16326531,   2.32653061,   2.48979592,
         2.65306122,   2.81632653,   2.97959184,   3.14285714,
         3.30612245,   3.46938776,   3.63265306,   3.79591837,
         3.95918367,   4.12244898,   4.28571429,   4.44897959,
         4.6122449 ,   4.7755102 ,   4.93877551,   5.10204082,
         5.26530612,   5.42857143,   5.59183673,   5.75510204,
         5.91836735,   6.08163265,   6.24489796,   6.40816327,
         6.57142857,   6.73469388,   6.89795918,   7.06122449,
         7.2244898 ,   7.3877551 ,   7.55102041,   7.71428571,
         7.87755102,   8.04081633,   8.20408163,   8.36734694,
         8.53061224,   8.69387755,   8.85714286,   9.02040816,
         9.18367347,   9.34693878,   9.51020408,   9.67346939,
         9.83673469,  10.        ])
```

### Development

For local development, especially when working across multiple images make sure to tag them as `ipython/scipystack`, `ipython/notebook`, etc. so they can depend on each other rather than upstream. Easy mode is to just use the Makefile:

```
make images
```

Otherwise, you can do it by hand:

```
docker build -t ipython/scipystack scipystack
```
