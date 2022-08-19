#!/bin/sh

echo ""
echo "------------------------------"
echo ""
echo "Running: matomo-init.sh"

echo "Copy config.ini.php into place"

cp /var/www/html/config/config.ini.php /config/config.ini.php

echo "Adjusting config permissions..."

chown 82:82 /config/config.ini.php
chmod 440 /config/config.ini.php

echo "Checking misc items"

if [ -f "/files/favicon.png" ]; then
  echo "Copying favicon..."
  base64 -d /files/favicon.png > /config/favicon.png
fi

if [ -f "/files/logo.png" ]; then
  echo "Copying logo..."
  base64 -d /files/logo.png > /config/logo.png
fi

if [ -f "/files/logo-header.png" ]; then
  echo "Copying logo-header..."
  base64 -d /files/logo-header.png > /config/logo-header.png
fi