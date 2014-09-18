#!/bin/bash

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

set LD_LIBRARY_PATH=/opt/grass/grass-7.1.svn/lib:$LD_LIBRARY_PATH
set PYTHONPATH=/opt/grass/grass-7.1.svn/etc/python:$PYTHONPATH
set GISBASE=/opt/grass/grass-7.1.svn/
set PATH=$PATH:$GISBASE/bin:$GISBASE/scripts
set GIS_LOCK=$$
set -p /notebooks/grass7data
set -p /notebooks/.grass7
set GISRC=/notebooks/.grass7/rc
set GISDBASE=/notebooks/grass7data

set GRASS_TRANSPARENT=TRUE
set GRASS_TRUECOLOR=TRUE
set GRASS_PNG_COMPRESSION=9
set GRASS_PNG_AUTO_WRITE=TRUE

ipython2 notebook --no-browser --port 8888 --ip=* --certfile=$PEM_FILE --NotebookApp.password="$HASH"
