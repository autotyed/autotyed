#!/bin/bash

# This script is far from done or perfect.
# TODO: Modify configs for all apps that support a prefix to have their respective http uri prefix.

# Check for brew. Install if missing.
brew -v >/dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "Installing homebrew. See https://brew.sh"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Gather brew dependencies.
echo "Installing grafana, influxdb, mono, nginx, certbot."
brew update
brew install grafana influxdb wget python mono jq nginx certbot

# Start metrics services.
echo "Starting InfluxDB and Grafana."
brew services start influxdb
brew services start grafana

# Nginx
echo "Creating a self-signed SSL certificate and starting nginx."
echo "If you're asked for your password, this is to start nginx on privileged ports."
sudo brew services stop nginx
[ -f /usr/local/etc/nginx/autotyed.key ] || openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /usr/local/etc/nginx/autotyed.key -out /usr/local/etc/nginx/autotyed.pem -subj "/C=US/ST=Earth/L=Jackson/O=Dis/CN=$(hostname -f)"
[ -f /usr/local/etc/nginx/dhparams ] || openssl dhparam 1024 -out /usr/local/etc/nginx/dhparams
cp autotyed.conf /usr/local/etc/nginx/servers/
cp -r www /usr/local/var/autotyed
sudo brew services start nginx

echo "Your password is also required for sudo to run easy_install to install glances and pip."
sudo easy_install --quiet glances influxdb pip

# Glances collects and stores system info.
echo "Starting Glances."
cp startup/macos/com.github.nicolargo.glances.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.github.nicolargo.glances.plist

sudo -H
echo "Now create an account to log into the https interface."
echo -n "Username: "
read username
htpasswd -c /usr/local/etc/nginx/htpasswd ${username}

# NZBGet (newsgroup/newsbin downloader)
echo "Installing and starting NZBGet."
wget -q https://github.com/nzbget/nzbget/releases/download/v20.0/nzbget-20.0-bin-macos.zip \
  -O ~/Downloads/nzbget-20.0-bin-macos.zip
unzip -nq ~/Downloads/nzbget-20.0-bin-macos.zip -d /Applications
open /Applications/NZBGet.app

# Deluge (downloading Torrents)
echo "Installing and starting Deluge."
wget -q --no-check-certificate https://download.deluge-torrent.org/mac_osx/deluge-1.3.15.1-macosx-x64.dmg \
  -O ~/Downloads/deluge-1.3.15.1-macosx-x64.dmg
hdiutil attach ~/Downloads/deluge-1.3.15.1-macosx-x64.dmg
cp -r /Volumes/deluge-1.3.15-macosx-x64/Deluge.app /Applications
diskutil umount /Volumes/deluge-1.3.15-macosx-x64/
cp startup/macos/com.deluge.deluged.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.deluge.deluged.plist

# Sonarr (TV series library)
echo "Installing and starting Sonarr."
wget -q https://download.sonarr.tv/v2/master/latest/NzbDrone.master.osx.zip \
  -O ~/Downloads/NzbDrone.master.osx.zip
unzip -nq ~/Downloads/NzbDrone.master.osx.zip -d /Applications
chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr
open /Applications/Sonarr.app

# Radarr (movie library)
echo "Installing and starting Radarr."
wget -q https://github.com/Radarr/Radarr/releases/download/v0.2.0.1293/Radarr.develop.0.2.0.1293.osx-app.zip \
  -O ~/Downloads/Radarr.develop.0.2.0.1293.osx-app.zip
unzip -nq ~/Downloads/Radarr.develop.0.2.0.1293.osx-app.zip -d /Applications
chmod +x /Applications/Radarr.app/Contents/MacOS/Radarr
open /Applications/Radarr.app

# Lidarr (music library)
echo "Installing and starting Lidarr."
wget -q https://github.com/lidarr/Lidarr/releases/download/v0.5.0.583/Lidarr.develop.0.5.0.583.osx-app.zip \
  -O ~/Downloads/Lidarr.develop.0.5.0.583.osx-app.zip
unzip -nq ~/Downloads/Lidarr.develop.0.5.0.583.osx-app.zip -d /Applications
chmod +x /Applications/Lidarr.app/Contents/MacOS/Lidarr
open /Applications/Lidarr.app

# Bazarr (subtitle sync and downloader)
echo "Installing and starting Bazarr."
git clone https://github.com/morpheus65535/bazarr.git /Applications/Bazarr.app
pip install --user -r /Applications/Bazarr.app/requirements.txt
cp startup/macos/com.github.morpheus65535.bazarr.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.github.morpheus65535.bazarr.plist

# Tautulli (for Plex graphs and stats)
echo "Installing and starting Tautulli."
git clone https://github.com/Tautulli/Tautulli.git /Applications/Tautulli.app
cp startup/macos/com.tautulli.tautulli.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.tautulli.tautulli.plist

# Jackett (used by Sonarr and Radarr to index specific trackers)
echo "Installing and starting Jackett."
wget -q https://github.com/Jackett/Jackett/releases/download/v0.11.31/Jackett.Binaries.Mono.tar.gz \
  -O ~/Downloads/Jackett.Binaries.Mono.tar.gz
tar -zxf ~/Downloads/Jackett.Binaries.Mono.tar.gz -C /Applications
mv /Applications/Jackett /Applications/Jackett.app
cp startup/macos/com.github.jackett.jackett.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.github.jackett.jackett.plist

# TODO: unpacker-poller
# - setup a new release to support easy automated installation.

echo
echo "Open Source Installs Complete:"
echo "- Homebrew, Grafana, InfluxDB, Glances"
echo "- Mono, Sonarr, Radarr, Lidarr, Bazarr"
echo "- Deluge, Tautulli, Jackett, NZBGet, Nginx"
echo
echo "Install these closed-source services manually:"
echo "- SecuritySpy - https://www.bensoftware.com/securityspy/download.html"
echo "- Indigo      - https://www.indigodomo.com/downloads.html"
echo "- UniFI       - https://www.ui.com/download/unifi/"
echo "- Plex        - https://plex.tv"
echo
echo "Access your new interface @ https://${username}@127.0.0.1/"
