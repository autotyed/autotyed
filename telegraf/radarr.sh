#!/bin/bash
# Prints out Radarr metrics in InfluxDB Line format.
# This allows you to graph your movie library changes over time.

APIKEY="APIKEYGOESHERE"
APIURL="http://127.0.0.1:7878/radarr"

JSON=$(/usr/bin/curl -s "${APIURL}/api/system/status?apikey=${APIKEY}")
KEYS=$(echo $JSON | /usr/local/bin/jq -r 'to_entries|map([.key] + [.value]|map(tostring)|join("="))|.[]' | sed 's/\([, ]\)/\\\1/g' | tr '\n' ',' | sed 's/,$//')

JSON=$(/usr/bin/curl -s "${APIURL}/api/wanted/missing?apikey=${APIKEY}&pageSize=1")
MISSING="missing=$(echo $JSON | /usr/local/bin/jq .totalRecords)"

JSON=$(/usr/bin/curl -s "${APIURL}/api/queue?apikey=${APIKEY}&pageSize=1")
QUEUE="queue=$(echo $JSON | /usr/local/bin/jq '. | length')"

JSON=$(/usr/bin/curl -s "${APIURL}/api/movie?apikey=${APIKEY}&pageSize=1")
TOTAL="total=$(echo $JSON | /usr/local/bin/jq .totalRecords)"

JSON=$(/usr/bin/curl -s "${APIURL}/api/wanted/cutoff?apikey=${APIKEY}&pageSize=1")
UNMET="unmet=$(echo $JSON | /usr/local/bin/jq .totalRecords)"

echo -n "radarr,${KEYS} ${MISSING},${QUEUE},${TOTAL},${UNMET}"
