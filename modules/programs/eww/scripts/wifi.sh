#!/bin/sh

if nmcli g | grep -q "connected"; then
	icon=""
	ssid=Oblivion
	status="Connected to ${ssid}"
else
	icon="睊"
	status="offline"
fi

echo "{\"icon\": \"${icon}\", \"status\": \"${status}\"}"
