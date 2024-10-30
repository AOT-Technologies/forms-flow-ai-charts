#!/bin/bash

# Check if the namespace was provided as an argument
if [ -z "$1" ]; then
  echo "Namespace not provided. Exiting..."
  exit 1
fi

# Retrieve the namespace from the argument
namespace="$1"
domain_name="$2"
analytics_subdomain="$3"

# Prompt the user for their Redash username
read -p "Enter your Redash username: " USERNAME

# Prompt the user for their Redash password (input hidden for security)
read -s -p "Enter your Redash password: " PASSWORD
echo

REDASH_URL="https://$analytics_subdomain-$namespace.$domain_name"
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
