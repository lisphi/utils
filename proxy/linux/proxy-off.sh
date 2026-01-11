#!/bin/bash

# Remove proxy
unset http_proxy
unset https_proxy
unset no_proxy
unset HTTP_PROXY
unset HTTPS_PROXY
unset NO_PROXY

# Check proxy
ip=$(curl -s https://api.ipify.org)
if [ -n "$ip" ] && [[ "$ip" =~ ^[0-9.]+$ ]]; then
    echo -e "IP Address: $ip"
    # Get geolocation info
    geo=$(curl -s "http://ip-api.com/json/$ip")
    country=$(echo $geo | jq -r '.country')
    region=$(echo $geo | jq -r '.regionName')
    city=$(echo $geo | jq -r '.city')
    echo -e "Location: $country $region $city"
else
    echo -e "Unable to get the outgoing IP, the network may be disconnected or blocked by a firewall."
fi

