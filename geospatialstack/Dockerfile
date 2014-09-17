FROM ipython/scipystack

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

ADD build_geospatial_stack.sh build_geospatial_stack.sh
RUN bash build_geospatial_stack.sh

## Extremely basic test of install
RUN python2 -c "import pyproj, shapely, fiona, geopandas, mplexporter, mplleaflet, geojson, mpl_toolkits.basemap, netCDF4"
RUN python3 -c "import pyproj, shapely, fiona, geopandas, mplexporter, mplleaflet, geojson, mpl_toolkits.basemap, netCDF4"

# Clean up from build
RUN rm -f /build_geospatial_stack.sh 
