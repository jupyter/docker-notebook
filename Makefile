images: scipyserver notebook notebook-onbuild scipystack

pull:
	docker pull ipython/ipython

notebook: notebook/Dockerfile
		docker build -t ipython/notebook notebook

notebook-onbuild: notebook
		docker build -t ipython/notebook:onbuild notebook-onbuild

scipystack: scipystack/Dockerfile
		docker build -t ipython/scipystack scipystack

scipyserver: scipystack scipyserver/Dockerfile
		docker build -t ipython/scipyserver scipyserver

.PHONY: pull scipystack scipyserver notebook notebook-onbuild
