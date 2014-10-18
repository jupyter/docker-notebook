FROM ipython/scipystack

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

ADD build_geospatial_dep.sh /tmp/build_geospatial_dep.sh
RUN bash /tmp/build_geospatial_dep.sh

ADD build_grass_gis.sh /tmp/build_grass_gis.sh
RUN bash /tmp/build_grass_gis.sh

ADD build_geospatial_stack.sh /tmp/build_geospatial_stack.sh
RUN bash /tmp/build_geospatial_stack.sh


ADD build_geospatial_web.sh /tmp/build_geospatial_web.sh
RUN bash /tmp/build_geospatial_web.sh

ADD build_bokeh.sh /tmp/build_bokeh.sh
RUN bash /tmp/build_bokeh.sh

ADD build_ipython_nb_extension.sh /tmp/build_ipython_nb_extension.sh
RUN bash /tmp/build_ipython_nb_extension.sh

## Extremely basic test of install
RUN python2 -c "import pyproj, shapely, geopandas, mplexporter, mplleaflet, geojson, mpl_toolkits.basemap, netCDF4, mock, shapefile, cartopy, numexpr, tables, astropy, geopy, OpenGL, PIL, spectral, rasterio"
RUN python3 -c "import pyproj, shapely, geopandas, mplexporter, geojson, mpl_toolkits.basemap, netCDF4, mock, shapefile, cartopy, numexpr, tables, astropy, geopy, OpenGL, PIL, spectral, rasterio"

# Clean up from build
RUN rm -f /tmp/build_geospatial_stack.sh /tmp/build_grass_gis.sh /tmp/build_geospatial_dep.sh /tmp/build_geospatial_web.sh /tmp/build_bokeh.sh