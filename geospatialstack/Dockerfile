FROM ipython/scipystack

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

ADD build_geospatial_dep.sh build_geospatial_dep.sh
RUN bash build_geospatial_dep.sh

ADD build_grass_gis.sh build_grass_gis.sh
RUN bash build_grass_gis.sh

ADD build_geospatial_stack.sh build_geospatial_stack.sh
RUN bash build_geospatial_stack.sh


ADD build_geospatial_web.sh build_geospatial_web.sh
RUN bash build_geospatial_web.sh

ADD build_bokeh.sh build_bokeh.sh
RUN bash build_bokeh.sh

## Extremely basic test of install
RUN python2 -c "import pyproj, shapely, geopandas, mplexporter, mplleaflet, geojson, mpl_toolkits.basemap, netCDF4, mock, shapefile, cartopy, numexpr, tables, astropy, geopy, OpenGL, PIL, spectral, rasterio"
RUN python3 -c "import pyproj, shapely, geopandas, mplexporter, geojson, mpl_toolkits.basemap, netCDF4, mock, shapefile, cartopy, numexpr, tables, astropy, geopy, OpenGL, PIL, spectral, rasterio"

# Clean up from build
RUN rm -f /build_geospatial_stack.sh