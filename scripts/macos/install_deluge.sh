#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# Deluge (downloading Torrents)
log "Deluge" "Installing and Starting!"
wget -q --no-check-certificate https://download.deluge-torrent.org/mac_osx/deluge-1.3.15.1-macosx-x64.dmg \
  -O ~/Downloads/deluge-1.3.15.1-macosx-x64.dmg
hdiutil attach -quiet ~/Downloads/deluge-1.3.15.1-macosx-x64.dmg
cp -r /Volumes/deluge-1.3.15-macosx-x64/Deluge.app /Applications
diskutil quiet umount /Volumes/deluge-1.3.15-macosx-x64/
cp startup/macos/org.deluge-torrent.deluged.plist ~/Library/LaunchAgents
cp startup/macos/org.deluge-torrent.deluge-web.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/org.deluge-torrent.deluged.plist
launchctl load ~/Library/LaunchAgents/org.deluge-torrent.deluge-web.plist
