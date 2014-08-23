Dockerized Notebook
===================

Docker container for the IPython notebook (single user).

## Quickstart

Assuming you have docker installed, run this to start up a notebook server on port 8888:

```
docker run -d -p 8888:8888 ipython/notebook
```

You'll now be able to access your notebook at https://localhost:8888 with password MakeAPassword (please change the environment variable above).

## Hacking on the Dockerfile

Clone this repository, make changes then build the container:

```
docker build -t notebook .
docker run -d -p 8888:8888 notebook
```
