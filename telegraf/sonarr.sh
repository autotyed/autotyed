#!/bin/bash
# Prints out Sonarr metrics in InfluxDB Line format.
# This allows you to graph your TV Series library changes over time.

APIKEY="APIKEYGOESHERE"
APIURL="http://127.0.0.1:8989/sonarr"

JSON=$(/usr/bin/curl -s "${APIURL}/api/system/status?apikey=${APIKEY}")
KEYS=$(echo $JSON | /usr/local/bin/jq -r 'to_entries|map([.key] + [.value]|map(tostring)|join("="))|.[]' | sed 's/\([, ]\)/\\\1/g' | tr '\n' ','| sed 's/,$//')

JSON=$(/usr/bin/curl -s "${APIURL}/api/wanted/missing?apikey=${APIKEY}&pageSize=1")
MISSING="missing=$(echo $JSON | /usr/local/bin/jq .totalRecords)"

JSON=$(/usr/bin/curl -s "${APIURL}/api/queue?apikey=${APIKEY}&pageSize=1")
QUEUE="queue=$(echo $JSON | /usr/local/bin/jq '. | length')"

JSON=$(/usr/bin/curl -s "${APIURL}/api/series?apikey=${APIKEY}")
SERIES="series=$(echo $JSON | /usr/local/bin/jq '. | length')"

JSON=$(/usr/bin/curl -s "${APIURL}/api/history?apikey=${APIKEY}&pageSize=1")
TOTAL="total=$(echo $JSON | /usr/local/bin/jq .totalRecords)"

JSON=$(/usr/bin/curl -s "${APIURL}/api/wanted/cutoff?apikey=${APIKEY}&pageSize=1")
UNMET="unmet=$(echo $JSON | /usr/local/bin/jq .totalRecords)"

echo -n "sonarr,${KEYS} ${MISSING},${QUEUE},${SERIES},${TOTAL},${UNMET}"
