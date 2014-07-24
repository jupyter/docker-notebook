docker-notebook
===============

Docker container for the IPython notebook (single user).

## Quickstart

Assuming you have docker installed, run this to start up a notebook server on port 8888:

```
docker run -d -p 8888:8888 ipython/notebook
```

## Hacking on the Dockerfile

Clone this repository

```
docker build -t notebook .
docker run -d -p 8888:8888 notebook
```
