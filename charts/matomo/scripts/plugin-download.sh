#!/bin/sh

echo ""
echo "------------------------------"
echo ""
echo "Running: plugin-download.sh"

# Get your license key @ https://shop.matomo.org/my-account/

if [ -z "$MATOMO_LICENSE_KEY" ]; then
  echo "Please check your Matomo Marketplace license key is correct, and try again." >&2
  exit 1
fi

if [ -z "$MATOMO_VERSION" ]; then
  echo "No version supplied. Please supply a Matomo version an try again." >&2
  exit 1
else
  MATOMO_CORE_VERSION=$1
fi

PLUGINS_TO_DOWNLOAD="{{ join " " .Values.plugins.custom.plugins }}"

for PLUGIN in $PLUGINS_TO_DOWNLOAD; do
  IFS=':' read -r PLUGIN_NAME PLUGIN_VERSION <<EOF
$PLUGIN
EOF

  echo "Downloading plugin $PLUGIN_NAME..."
  if curl -f -sS --data "access_token=$MATOMO_LICENSE_KEY" "https://plugins.matomo.org/api/2.0/plugins/$PLUGIN_NAME/download/${PLUGIN_VERSION:-latest}?matomo=$MATOMO_CORE_VERSION" >"plugins-$PLUGIN_NAME.zip"; then
    echo "OK"
  else
    echo "Please check your Matomo Marketplace license key is correct, and try again." >&2
    exit 1
  fi
done

echo "Extract all packages in the /custom-plugins/ directory..."

for PLUGIN in $PLUGINS_TO_DOWNLOAD; do
  IFS=':' read -r PLUGIN_NAME PLUGIN_VERSION <<EOF
$PLUGIN
EOF

  unzip -q -o "plugins-$PLUGIN_NAME" -d /custom-plugins/
done

echo "Installing Matomo queue monitoring plugin..."
curl -f -sSL https://github.com/MakairaIO/matomo-queue-monitoring/archive/refs/heads/stable.tar.gz > /tmp/plugins-matomo-queue-monitoring.tar.gz
mkdir -p /custom-plugins/QueueMonitoring
tar --strip-components=1 -xzf /tmp/plugins-matomo-queue-monitoring.tar.gz -C /custom-plugins/QueueMonitoring

echo "Adjusting permissions..."

chown -R 82:82 /custom-plugins

echo "Done extracting files!"
