#!/bin/bash

# Install Open Source Dependencies on a Mac!
# It's reasonably safe to re-run this script.

# Check for brew. Install if missing.
scripts/macos/install_brew.sh
# Nginx reverse proxy & web server.
scripts/macos/install_nginx.sh
# Glances collects and stores system info.
scripts/macos/install_glances.sh
# NZBGet (newsgroup/newsbin downloader)
scripts/macos/install_nzbget.sh
# Deluge (downloading Torrents)
scripts/macos/install_deluge.sh
# Sonarr (TV series library)
scripts/macos/install_sonarr.sh
# Radarr (movie library)
scripts/macos/install_radarr.sh
# Lidarr (music library)
scripts/macos/install_lidarr.sh
# Bazarr (subtitle sync and downloader)
scripts/macos/install_bazarr.sh
# Tautulli (for Plex graphs and stats)
scripts/macos/install_tautulli.sh
# Jackett (used by Sonarr and Radarr to index specific trackers)
scripts/macos/install_jackett.sh
# TODO: unpacker-poller
#scripts/macos/install_unpacker.sh
# - setup a new release to support easy automated installation.

function log {
  echo -e "\033[0;32m$1\033[0m: \033[1;34m$2\033[0m"
}

echo
log "Open Source Installs Complete"
log "##" "Homebrew, Grafana, InfluxDB, Glances"
log "##" "Mono, Sonarr, Radarr, Lidarr, Bazarr"
log "##" "Deluge, Tautulli, Jackett, NZBGet, Nginx"
echo
log "Install these closed-source services manually"
log "- SecuritySpy" "https://www.bensoftware.com/securityspy/download.html"
log "- Indigo" "     https://www.indigodomo.com/downloads.html"
log "- UniFI" "      https://www.ui.com/download/unifi/"
log "- Plex" "       https://plex.tv"
echo
log "Info" "Access your new interface @ https://${username}@127.0.0.1/"
