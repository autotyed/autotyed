#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

version=0.2.0.1293
# Radarr (movie library)
log "Radarr" "Installing and Starting!"
wget -q https://github.com/Radarr/Radarr/releases/download/v${version}/Radarr.develop.${version}.osx-app.zip \
  -O ~/Downloads/Radarr.develop.${version}.osx-app.zip
unzip -nq ~/Downloads/Radarr.develop.${version}.osx-app.zip -d /Applications
chmod +x /Applications/Radarr.app/Contents/MacOS/Radarr
# Open Radarr to create the default config file so it can be edited.
cp startup/macos/video.radarr.radarr.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/video.radarr.radarr.plist
launchctl unload ~/Library/LaunchAgents/video.radarr.radarr.plist
sed -i ".pre-autotyed" 's#<UrlBase.*#<UrlBase>/radarr/</UrlBase>#' ~/.config/Radarr/config.xml
launchctl load ~/Library/LaunchAgents/video.radarr.radarr.plist
