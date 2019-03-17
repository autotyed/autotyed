#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# Lidarr (music library)
log "Lidarr" "Installing and Starting!"
wget -q https://github.com/lidarr/Lidarr/releases/download/v0.5.0.583/Lidarr.develop.0.5.0.583.osx-app.zip \
  -O ~/Downloads/Lidarr.develop.0.5.0.583.osx-app.zip
unzip -nq ~/Downloads/Lidarr.develop.0.5.0.583.osx-app.zip -d /Applications
chmod +x /Applications/Lidarr.app/Contents/MacOS/Lidarr
# Open Lidarr to create the default config file so it can be edited.
cp startup/macos/audio.lidarr.lidarr.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/audio.lidarr.lidarr.plist
launchctl unload ~/Library/LaunchAgents/audio.lidarr.lidarr.plist
sed -i ".pre-autotyed" 's#<UrlBase.*#<UrlBase>/lidarr/</UrlBase>#' ~/.config/Lidarr/config.xml
launchctl load ~/Library/LaunchAgents/audio.lidarr.lidarr.plist
