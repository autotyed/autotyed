#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# Check for brew. Install if missing.
brew -v >/dev/null 2>&1
if [ "$?" != "0" ]; then
  log "Homebrew" "Installing! See https://brew.sh"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Gather brew dependencies.
log "Installing" "grafana, influxdb, mono, nginx, certbot."
brew update
brew install grafana influxdb wget python mono jq nginx certbot

# Start metrics services.
log "InfluxDB" "Starting!"
brew services start influxdb

log "Grafana" "Configuring proxy auth and starting!"
sed -e '/\[server\]/,/\[/s/;*root_url.*/root_url = %(protocol)s:\/\/%(domain)s:%(http_port)s\/grafana\//g' \
  -e '/\[auth.proxy\]/,/\[/s/;*enabled.*/enabled = true/g' \
  -e '/\[auth.proxy\]/,/\[/s/;*header_name.*/header_name = X-WEBAUTH-USER/g' \
  -e '/\[auth.proxy\]/,/\[/s/;*header_property.*/header_property = username/g' \
  -e '/\[auth.proxy\]/,/\[/s/;*auto_sign_up.*/auto_sign_up = true/g' \
  -e '/\[auth.proxy\]/,/\[/s/;*whitelist.*/whitelist = 127.0.0.1,localhost/g' \
  -e '/\[auth.basic\]/,/\[/s/;*enabled.*/enabled = false/g' \
  -i ".pre-autotyed" /usr/local/etc/grafana/grafana.ini
brew services start grafana
