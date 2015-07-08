#!/bin/bash

### SET VARIABLES
USER_NAME=thcr
APP_DIR=/opt
USER_DIR=/downloads
FETCH_DIR=/fetch
CONFIG_DIR=/etc/thcr

### MANAGE USER AND VOLUME OWNERSHIP
if [[ ! $(grep --quiet '$CONFIG_DIR' /etc/passwd) ]]; then
  ### CREATE APPLICAITON USER
  echo "$USER_NAME:x:$UID:$GID:$USER_NAME,,,:$CONFIG_DIR:/bin/bash" >> /etc/passwd
  echo "$USER_NAME:x:$GID:" >> /etc/group
  ### CRETE SSL KEYPAIR
  openssl req -new -newkey rsa:4096 -days 7305 -nodes -x509 \
  -subj "/C=AC/ST=Freedom/L=Internet/O=IT/CN=dockerbox.com" \
  -out /etc/thcr/nginx/certs/public.cert \
  -keyout /etc/thcr/nginx/certs/private.key 2>/dev/null
  ### ASSIGN VOLUME OWNERSHIP
  mkdir -p $CONFIG_DIR
  mkdir -p $FETCH_DIR
  mkdir -p $USER_DIR
  chown $UID:$GID -R $APP_DIR
  chown $UID:$GID -R $CONFIG_DIR
  chown $UID:$GID -R $FETCH_DIR
  chown $UID:$GID -R $USER_DIR
fi

### START SERVICE USING RUNTIME UID AND GID
exec su - $USER_NAME -c "$CONFIG_DIR/.thcr 2>&1" 2>/dev/null &

### START NGINX AS ROOT
/usr/sbin/nginx -c /etc/thcr/nginx/nginx.conf 2>&1
