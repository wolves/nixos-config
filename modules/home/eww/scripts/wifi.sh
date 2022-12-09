#!/bin/sh

SSID_NAME=$(nmcli dev status | rg wifi | xargs | awk '/^wlp170s0/ {print $4}')
if nmcli g | rg -q "connected"; then
	icon=""
	ssid=${SSID_NAME}
	status="Connected to ${ssid}"
else
	icon="睊"
	status="offline"
fi

echo "{\"icon\": \"${icon}\", \"status\": \"${status}\"}"
