#!/usr/bin/env bash
#
# install apache (needed by mapserver)
apt-get install --yes apache2
mkdir -p /var/www/html
wget -nv http://ipython.org/_static/favicon.ico -O http://ipython.org/_static/favicon.ico

PACKAGES="gmt gmt-doc gmt-gshhs-low \
   gmt-examples gmt-tutorial gmt-tutorial-pdf gv"

# pkg not installed to save 15mb disc space:
#   gmt-doc-pdf gmt-gshhs-full gmt-gshhs-high

apt-get --assume-yes install $PACKAGES

cat << EOF > /etc/profile.d/gmt_path.sh
PATH="\$PATH:/usr/lib/gmt/bin"
export PATH
EOF

apt-get --assume-yes install libjs-leaflet
#add-apt-repository --yes --remove ppa:johanvdw/leafletjs

ln -s /usr/share/javascript/leaflet/ /var/www/html/leaflet


MS_APACHE_CONF_FILE="mapserver.conf"
APACHE_CONF_DIR="/etc/apache2/conf-available/"
APACHE_CONF_ENABLED_DIR="/etc/apache2/conf-enabled/"
MS_APACHE_CONF=$APACHE_CONF_DIR$MS_APACHE_CONF_FILE

apt-get install --yes cgi-mapserver mapserver-bin php5-mapscript \
   python-mapscript

# Add MapServer apache configuration
cat << EOF > "$MS_APACHE_CONF"
EnableSendfile off
DirectoryIndex index.phtml
Alias /mapserver "/usr/local/share/mapserver"
Alias /ms_tmp "/tmp"
Alias /tmp "/tmp"
Alias /mapserver_demos "/usr/local/share/mapserver/demos"

<Directory "/usr/local/share/mapserver">
  Require all granted
  Options +Indexes
</Directory>

<Directory "/usr/local/share/mapserver/demos">
  Require all granted
  Options +Indexes
</Directory>

<Directory "/tmp">
  Require all granted
  Options +Indexes
</Directory>
EOF

a2enconf $MS_APACHE_CONF_FILE
echo "Finished configuring Apache"

echo "\nFetching git clone..."
if [ ! -d "openlayers" ] ; then
    git clone https://github.com/openlayers/openlayers.git
else
    echo "... openLayers already cloned"
fi

cd openlayers

echo "\nBuilding examples index"
if [ ! -s examples/example-list.js ] ; then
    cd tools
    ./exampleparser.py
    cd ..
else
    echo "... example index already built"
fi

ln -sf example-list.html examples/index.html
echo "Done."

echo "\nBuilding full uncompressed OpenLayers.js"
cd build
./buildUncompressed.py
cd ..
ln -sf build/OpenLayers.js

mkdir -p /var/www/html/openlayers
cp -R openlayers/* /var/www/html/openlayers/
chmod -R uga+r /var/www/html/openlayers