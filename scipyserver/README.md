Dockerized Notebook + SciPy Stack
=================================

Docker container for the [SciPy stack](../scipystack) and configured IPython notebook server.

## Quickstart

Assuming you have docker installed, run this to start up a notebook server on https://localhost.

```
docker run -d -p 443:8888 -e "PASSWORD=MakeAPassword" ipython/scipyserver
```

You'll now be able to access your notebook at https://localhost with password MakeAPassword (please change the environment variable above).

## Hacking on the Dockerfile

Clone this repository, make changes then build the container:

```
docker build -t scipyserver .
docker run -d -p 443:8888 -e "PASSWORD=MakeAPassword" scipyserver
```

## Use your own certificate
This image looks for `/key.pem`. If it doesn't exist a self signed certificate will be made. If you would like to use your own certificate, concatenate your private and public key along with possible intermediate certificates in a pem file. The order should be (top to bottom): key, certificate, intermediate certificate.

Example:
```
cat hostname.key hostname.pub.cert intermidiate.cert > hostname.pem
```

Then you would mount this file to the docker container:
```
docker run -v /path/to/hostname.pem:/key.pem -d -p 443:8888 -e "PASSWORD=pass" ipython/scipyserver
```
