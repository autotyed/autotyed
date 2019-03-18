#!/bin/bash
# Prints out Sonarr metrics in InfluxDB Line format.
# This allows you to graph a pieces of data from Plex in Grafana.

APIKEY="APIKEYGOESHERE"
APIURL="http://127.0.0.1:8181/tautulli/api/v2?apikey=${APIKEY}"

JSON=$(/usr/bin/curl -s "${APIURL}&cmd=get_activity")
JSON=$(echo $JSON | /usr/local/bin/jq -r '.response.data | {stream_count,total_bandwidth,stream_count_transcode,wan_bandwidth,stream_count_direct_play,lan_bandwidth,stream_count_direct_stream}')
KEYS=$(echo $JSON | /usr/local/bin/jq -r 'to_entries|map([.key] + [.value]|map(tostring)|join("="))|.[]' | sed 's/\([, ]\)/\\\1/g' | tr '\n' ','| sed 's/,$//')
NAME="name=$(/usr/bin/curl -s "${APIURL}&cmd=get_server_friendly_name" | /usr/local/bin/jq -r .response.data | sed 's/\([, ]\)/\\\1/g')"
echo -n "plex,${NAME} ${KEYS}"
