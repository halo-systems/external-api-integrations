#!/bin/bash

# Call HaloWiFi API to change the location of a networking device
# Usage: ./change-wifi-router-location.sh <token> <networking_device_id> <location_id>
# Example: ./change-wifi-router-location.sh eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9... 123e4567-e89b-12d3-a456-426614174000 987fcdeb-51d2-11e9-8647-d663bd873d93

token=$1
networking_device_id=$2
location_id=$3
API_URL="https://one.halowifi.com/api/external/networking-device/$networking_device_id/update-location"

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Error: Missing arguments"
    echo "Usage: ./change-wifi-router-location.sh <token> <networking_device_id> <location_id>"
    echo "Example: ./change-wifi-router-location.sh eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9... 123e4567-e89b-12d3-a456-426614174000 987fcdeb-51d2-11e9-8647-d663bd873d93"
    exit 1
fi

update_location_response=$(curl -X POST "$API_URL" \
  -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json" \
  -d "{\"location_id\": \"$location_id\"}")

if echo "$update_location_response" | jq -e '.status' | grep -q 'success'; then
    echo "Location updated successfully:"
    echo "$update_location_response"
else
    echo "Failed to update location:"
    echo "$update_location_response"
fi