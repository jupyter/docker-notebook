images: scipyserver notebook scipystack

pull:
	docker pull ipython/ipython

notebook: notebook/Dockerfile
		docker build -t ipython/notebook notebook

scipystack: scipystack/Dockerfile
		docker build -t ipython/scipystack scipystack

scipyserver: scipystack scipyserver/Dockerfile
		docker build -t ipython/scipyserver scipyserver

.PHONY: pull scipystack scipyserver notebook
