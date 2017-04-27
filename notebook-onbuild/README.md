Build an image with packages from the PyPI
==========================================

You can build your own image that includes additional packages you need for your task.

For example, to access a MySQL-database with the ORM-framework *SQLAlchemy*, create a directory and put these files into it:

`Dockerfile`

```
FROM  ipython/notebook:onbuild
```

`apt-dependencies.txt` (packages from the [Ubuntu-repository](http://packages.ubuntu.com/trusty/))

```
libmysqlclient-dev
```

`requirements.txt` (packages from the [Python Package Index](https://pypi.python.org/pypi))

```
mysqlclient
SQLAlchemy
```

Then change into that directory and build the image:

    $ docker build -t myproject .
