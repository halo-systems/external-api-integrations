#!/bin/bash
# Script to add network device to HaloWiFi

# Check if required arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <api_token> <location_id> <networking_device_id>"
    echo "Example: $0 your-api-token ad0e7cc3-d7d4-401b-a35a-4957a1fc8009 e33e9fc2-1e5d-4c3b-8a00-999b6e4c8f3a"
    exit 1
fi

API_TOKEN="$1"
LOCATION_ID="$2"
NETWORKING_DEVICE_ID="$3"

# API endpoint
API_URL="https://one.halowifi.com/api/external/location/${LOCATION_ID}/networking-devices/add"

# Request payload
PAYLOAD='{
    "networking_device_id": "'${NETWORKING_DEVICE_ID}'"
}'

# Make the API request
response=$(curl -s -X POST "${API_URL}" \
    -H "Authorization: Bearer ${API_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "${PAYLOAD}")

# Output the response
echo "Response:"
echo "${response}" | jq '.' 2>/dev/null || echo "${response}"

exit 0
