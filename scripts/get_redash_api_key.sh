#!/bin/bash

# Check if the class name was provided as an argument
if [ -z "$1" ]; then
  echo "Class name not provided. Exiting..."
  exit 1
fi

# Retrieve the class name from the argument
CLASSNAME="$1"

# Redash instance details
REDASH_URL="https://your-redash-url.com"  # Replace with your Redash URL
USERNAME="your_username"                  # Replace with your Redash username
PASSWORD="your_password"                  # Replace with your Redash password

# Step 1: Authenticate and get session cookie
LOGIN_RESPONSE=$(curl -s -X POST "$REDASH_URL/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "email=$USERNAME" \
  --data-urlencode "password=$PASSWORD" \
  -c cookies.txt)

# Check if login was successful
if ! echo "$LOGIN_RESPONSE" | grep -q 'Redirecting'; then
  echo "Login failed!"
  exit 1
fi

echo "Login successful"

# Step 2: Retrieve the API key
API_RESPONSE=$(curl -s -X GET "$REDASH_URL/api/users/me" \
  -b cookies.txt)

# Extract the API key
API_KEY=$(echo "$API_RESPONSE" | grep -Po '"api_key": *"\K[^"]*')

# Check if API key is extracted
if [ -z "$API_KEY" ]; then
  echo "Failed to retrieve API key!"
  exit 1
fi

# Return the API key
echo "$API_KEY"

# Cleanup cookies file
rm cookies.txt
