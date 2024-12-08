#!/bin/bash

# Call HaloWiFi API to generate tokens

# Usage: pass api_key and api_secret as arguments to generate tokens. You can also pass expiration date as an argument.
# Example: ./generate-tokens.sh 1234567890 0123456789 --expires_at="2024-03-21T15:30:00Z"
# Geneate API Key and API Secret from https://one.halowifi.com/api/external/token

api_key=$1
api_secret=$2
api_domain="https://one.halowifi.com"

if [ -z "$1" ] || [ -z "$2" ]; then
    echo 
    echo "Error:"
    echo "Usage: ./generate-tokens.sh api_key api_secret [expires_at]"
    echo "Example: ./generate-tokens.sh 1234567890 0123456789 --expires_at=\"2024-12-31\""
    echo "Example: ./generate-tokens.sh 1234567890 0123456789"
    echo "API key and API secret are required. If expires_at is not provided, the token will be generated with 1 dat validity."
    echo "Generate API Key and API Secret from https://one.halowifi.com/api/external/token"
    echo 
    exit 1
fi

# Extract expires_at value if provided
expires_at=""
if [[ "$3" =~ ^--expires_at=(.*)$ ]]; then
    expires_at="${BASH_REMATCH[1]}"
fi

if [ -z "$expires_at" ]; then
    token_response=$(curl -X POST "$api_domain/api/external/token?api_key=$api_key&api_secret=$api_secret")
else
    # URL Encode expires_at
    expires_at_encoded=$(printf "%s" "$expires_at" | jq -sRr @uri)
    token_response=$(curl -X POST "$api_domain/api/external/token?api_key=$api_key&api_secret=$api_secret&expires_at=$expires_at_encoded")
fi

# If token_response status is success, print the token and expires_at else print the error
if echo "$token_response" | jq -e '.status' | grep -q 'success'; then
    echo "Token generated successfully:"
    echo "Token: $(echo "$token_response" | jq -r '.token')"
    echo "Expires at: $(echo "$token_response" | jq -r '.expires_at')"
else
    echo "Error:"
    echo "$(echo "$token_response" | jq -r '.message')"
fi