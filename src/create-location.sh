#!/bin/bash

# Call HaloWiFi API to create a location
# Usage: ./create-location.sh <token>
# Modify location data as needed

# API endpoint and authentication
API_URL="https://one.halowifi.com/api/external/locations/add"
token=$1

echo $API_URL
if [ -z "$1" ]; then
    echo 
    echo "Error:"
    echo "Usage: ./create-location.sh <token>"
    echo "Example: ./create-location.sh eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
    echo "Generate token using generate-tokens.sh"

    echo 
    exit 1
fi

# Location data
DATA='{
    "name": "Test Location",
    "address": "123 Main Street", 
    "city": "New York",
    "state": "NY",
    "postal": "10001",
    "country": "United States",
    "contact_phone_no": "+1234567890",
    "contact_email": "test@example.com"
}'

# Make API call
response=$(curl -X POST "$API_URL" \
  -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json" \
  -d "$DATA")

# Check if response contains success status
if echo "$response" | jq -e '.status' | grep -q 'success'; then
    echo 
    echo "Location created successfully:"
    echo "$response"
else
    echo 
    echo "Failed to create location:"
    echo "$response"
fi

