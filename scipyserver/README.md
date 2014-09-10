Dockerized Notebook + SciPy Stack
=================================

Docker container for the [SciPy stack](../scipystack) and configured IPython notebook server.

## Quickstart

Assuming you have docker installed, run this to start up a notebook server on port 8888:

```
docker run -d -p 8888:8888 -e "PASSWORD=MakeAPassword" ipython/scipyserver
```

You'll now be able to access your notebook at https://localhost:8888 with password MakeAPassword (please change the environment variable above).

## Hacking on the Dockerfile

Clone this repository, make changes then build the container:

```
docker build -t scipyserver .
docker run -d -p 8888:8888 -e "PASSWORD=MakeAPassword" scipyserver
```

## Use your own certificate
IPython notebook looks for /key.pem, if it doesn't exists a self signed certificate will be made. If you would like to use your own certificate, concaticate your private and public key along with possible intermediate certificates in a pem file. The order should be (top to bottom): key, certificate, intermediate certificate.

Ex:
```
cat hostname.key hostname.pub.cert intermidiate.cert > hostname.pem
```

Then you would mount this file to the docker container:
```
docker run -v /path/to/hostname.pem:/key.pem ipython/scipyserver
```
