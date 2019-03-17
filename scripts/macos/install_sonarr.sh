#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# Sonarr (TV series library)
log "Sonarr" "Installing and Starting!"
wget -q https://download.sonarr.tv/v2/master/latest/NzbDrone.master.osx.zip \
  -O ~/Downloads/NzbDrone.master.osx.zip
unzip -nq ~/Downloads/NzbDrone.master.osx.zip -d /Applications
chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr
# Open Sonarr to create the default config file so it can be edited.
cp startup/macos/tv.sonarr.sonarr.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/tv.sonarr.sonarr.plist
launchctl unload ~/Library/LaunchAgents/tv.sonarr.sonarr.plist
sed -i ".pre-autotyed" 's#<UrlBase.*#<UrlBase>/sonarr/</UrlBase>#' ~/.config/NzbDrone/config.xml
launchctl load ~/Library/LaunchAgents/tv.sonarr.sonarr.plist
