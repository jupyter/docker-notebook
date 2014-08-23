Dockerized Notebook + SciPy Stack
=================================

Docker container for the SciPy stack and configured IPython notebook server.

## Quickstart

Assuming you have docker installed, run this to start up a notebook server on port 8888:

```
docker run -d -p 8888:8888 ipython/scipyserver
```

You'll now be able to access your notebook at https://localhost:8888 with password MakeAPassword (please change the environment variable above).

## Hacking on the Dockerfile

Clone this repository, make changes then build the container:

```
docker build -t scipyserver .
docker run -d -p 8888:8888 scipyserver
```
