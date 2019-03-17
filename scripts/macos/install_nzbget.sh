#!/bin/bash

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

# NZBGet (newsgroup/newsbin downloader)
log "NZBGet" "Installing and Starting!"
wget -q https://github.com/nzbget/nzbget/releases/download/v20.0/nzbget-20.0-bin-macos.zip \
  -O ~/Downloads/nzbget-20.0-bin-macos.zip
unzip -nq ~/Downloads/nzbget-20.0-bin-macos.zip -d /Applications
open /Applications/NZBGet.app
