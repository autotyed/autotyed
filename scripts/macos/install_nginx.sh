#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# Nginx
if [ ! -f /usr/local/etc/nginx/autotyed.key ]; then
  log "Info" "Creating a self-signed SSL certificate for nginx."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /usr/local/etc/nginx/autotyed.key -out /usr/local/etc/nginx/autotyed.pem \
    -subj "/C=US/ST=Earth/L=Jackson/O=Dis/CN=$(hostname -f)"
  openssl dhparam 1024 -out /usr/local/etc/nginx/dhparams
fi
cp autotyed.conf /usr/local/etc/nginx/servers/
mkdir -p /usr/local/var/autotyed
cp -r www/* /usr/local/var/autotyed/

if [ ! -f /usr/local/etc/nginx/htpasswd ]; then
  log "Notice" "Creating httpauth account to log into the https interface."
  echo -ne "\033[1;31mUsername: "
  read username
  htpasswd -c /usr/local/etc/nginx/htpasswd ${username}
  echo -ne "\\033[0m"
fi
# The Indigo control paths have a different password file, so non-admins can't control your house.
[ -f /usr/local/etc/nginx/htpasswd_admins ] || cp /usr/local/etc/nginx/htpasswd /usr/local/etc/nginx/htpasswd_admins

log "Notice" "If sudo asks for your password, this is to start nginx on privileged ports."
sudo brew services restart nginx
