#!/bin/bash -l


export LD_LIBRARY_PATH=/opt/grass/grass-7.1.svn/lib:$LD_LIBRARY_PATH
export PYTHONPATH=/opt/grass/grass-7.1.svn/etc/python:$PYTHONPATH
export GISBASE=/opt/grass/grass-7.1.svn/
export PATH=$PATH:$GISBASE/bin:$GISBASE/scripts
export GIS_LOCK=$$
mkdir -p /notebooks/grass7data
mkdir -p /notebooks/.grass7
export GISRC=/notebooks/.grass7/rc
export GISDBASE=/notebooks/grass7data

export GRASS_TRANSPARENT=TRUE
export GRASS_TRUECOLOR=TRUE
export GRASS_PNG_COMPRESSION=9
export GRASS_PNG_AUTO_WRITE=TRUE


# Strict mode
set -euo pipefail
IFS=$'\n\t' 

# Create a self signed certificate for the user if one doesn't exist
if [ ! -f $PEM_FILE ]; then
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $PEM_FILE -out $PEM_FILE \
    -subj "/C=XX/ST=XX/L=XX/O=dockergenerated/CN=dockergenerated"
fi

# Create the hash to pass to the IPython notebook, but don't export it so it doesn't appear
# as an environment variable within IPython kernels themselves
HASH=$(python3 -c "from IPython.lib import passwd; print(passwd('${PASSWORD}'))")
unset PASSWORD

ipython2 notebook --no-browser --port 8888 --ip=* --certfile=$PEM_FILE --NotebookApp.password="$HASH"
