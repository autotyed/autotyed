#!/bin/bash

# This isn't done. Probably not easy to script anyway.
# Go read the directions for certbot and make a cert. :D

set -o -e pipefail

echo "Attempting to create SSL certificate with certbot."
sudo certbot --nginx
#sudo brew services start nginx

# Setup a crontab to renew certbot. This works. You can use this.
# Literally copy/paste the following into your terminal window.
HOUR1=$((1 + RANDOM % 12))
HOUR2=$((HOUR1 + 11))
MIN=$((1 + RANDOM % 59))
CURRENT=$(crontab -l)
crontab << EOF
${CURRENT}
${MIN} ${HOUR1},${HOUR2} * * * certbot renew
EOF
