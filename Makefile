images: base scipyserver notebook scipystack

base: base/Dockerfile
		docker build -t ipython/base base

notebook: notebook/Dockerfile
		docker build -t ipython/notebook notebook

scipystack: base scipystack/Dockerfile
		docker build -t ipython/scipystack scipystack

geospatialstack: scipystack geospatialstack/Dockerfile
		docker build -t ipython/geospatialstack geospatialstack


scipyserver: geospatialstack scipyserver/Dockerfile
		docker build -t ipython/scipyserver scipyserver

.PHONY: base scipystack geospatialstack scipyserver notebook
