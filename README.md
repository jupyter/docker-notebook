Dockerized Notebook
===================

Docker container for the IPython notebook (single user).

## Quickstart

Assuming you have docker installed, run this to start up a notebook server on port 8888:

```
docker run -d -p 8888:8888 ipython/notebook
```

## Hacking on the Dockerfile

Clone this repository, make changes then build the container:

```
docker build -t notebook .
docker run -d -p 8888:8888 notebook
```

If you have any suggestions including baseline software that you think should be installed, submit an issue or a pull request!
