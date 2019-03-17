#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# Tautulli (for Plex graphs and stats)
log "Tautulli" "Installing and Starting!"
[ -d  /Applications/Tautulli.app ] || git clone https://github.com/Tautulli/Tautulli.git /Applications/Tautulli.app
cp startup/macos/com.tautulli.tautulli.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.tautulli.tautulli.plist
launchctl unload ~/Library/LaunchAgents/com.tautulli.tautulli.plist
# This doesn't actually seem to work. You still have to set base url in the wizard.
sed -i ".pre-autotyed" 's#http_base_url .*#http_base_url = "/tautulli/"#' /Applications/Tautulli.app/config.ini
launchctl load ~/Library/LaunchAgents/com.tautulli.tautulli.plist
