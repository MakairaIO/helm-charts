#!/bin/sh

echo ""
echo "------------------------------"
echo ""
echo "Running: update-ipdb.sh"

databases="{{ join " " .Values.geoip.databases }}"
for database in $databases; do
  printf "Downloading MaxMind %s Database\\n" "$database"
  wget -O download.tar.gz "https://download.maxmind.com/app/geoip_download?edition_id=$database&license_key=$MATOMO_MAXMIND_LICENSE&suffix=tar.gz"
  printf "Unzipping...\\n"
  tar -xf download.tar.gz
  printf "Moving file...\\n"
  mv "$database""_*/$database." "/geoip/$database."
  printf "Setting permission for %s\\n" "$database"
  chown 82:82 "/geoip/$database."
done

