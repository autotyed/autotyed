#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# Bazarr (subtitle sync and downloader)
log "Bazarr" "Installing and Starting!"
[ -d /Applications/Bazarr.app ] || git clone https://github.com/morpheus65535/bazarr.git /Applications/Bazarr.app
pip2.7 install --quiet --user -r /Applications/Bazarr.app/requirements.txt
cp startup/macos/com.github.morpheus65535.bazarr.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.github.morpheus65535.bazarr.plist
launchctl unload ~/Library/LaunchAgents/com.github.morpheus65535.bazarr.plist
sed -i ".pre-autotyed" '/\[general\]/,//s/base_url.*/base_url = \/bazarr\//g' /Applications/Bazarr.app/data/config/config.ini
launchctl load ~/Library/LaunchAgents/com.github.morpheus65535.bazarr.plist
