#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# Jackett (used by Sonarr and Radarr to index specific trackers)
log "Jackett" "Installing and Starting!"
if [ ! -d /Applications/Jackett.app ]; then
  wget -q https://github.com/Jackett/Jackett/releases/download/v0.11.31/Jackett.Binaries.Mono.tar.gz \
    -O ~/Downloads/Jackett.Binaries.Mono.tar.gz
  tar -zxf ~/Downloads/Jackett.Binaries.Mono.tar.gz -C /Applications
  mv /Applications/Jackett /Applications/Jackett.app
fi
cp startup/macos/com.github.jackett.jackett.plist ~/Library/LaunchAgents
# install mono certificate store
curl -sS https://curl.haxx.se/ca/cacert.pem | cert-sync --quiet --user /dev/stdin
launchctl load ~/Library/LaunchAgents/com.github.jackett.jackett.plist
launchctl unload ~/Library/LaunchAgents/com.github.jackett.jackett.plist
sed -i ".pre-autotyed" 's#\"BasePathOverride.*#\"BasePathOverride\": \"/jackett/",#' ~/.config/Jackett/ServerConfig.json
launchctl load ~/Library/LaunchAgents/com.github.jackett.jackett.plist
