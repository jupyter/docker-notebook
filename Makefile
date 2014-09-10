images: base scipyserver notebook scipystack

base: base/Dockerfile
		docker build -t ipython/base base

notebook: notebook/Dockerfile
		docker build -t ipython/notebook notebook

scipystack: base scipystack/Dockerfile
		docker build -t ipython/scipystack scipystack

scipyserver: scipystack scipyserver/Dockerfile
		docker build -t ipython/scipyserver scipyserver

.PHONY: base scipystack scipyserver notebook
