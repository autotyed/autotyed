#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

log "Notice" "Your password is required for sudo to run easy_install to install glances, influxdb and pip."
sudo easy_install --quiet glances influxdb pip

# Glances collects and stores system info.
log "Glances" "Starting!"
cp startup/macos/com.github.nicolargo.glances.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.github.nicolargo.glances.plist
