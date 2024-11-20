#!/bin/bash

# Ensure namespace is provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: $0 <namespace> <domain_name> <analytics_subdomain>"
  exit 1
fi

NAMESPACE="$1"
DOMAIN_NAME="$2"
ANALYTICS_SUBDOMAIN="$3"

# Check if forms-flow-analytics is installed
if helm status "forms-flow-analytics" -n "$NAMESPACE" > /dev/null 2>&1; then
  echo "forms-flow-analytics is already installed."
else
  echo "forms-flow-analytics does not exist. Installing now."
  helm install "forms-flow-analytics" ./forms-flow-analytics-chart -n "$NAMESPACE"
fi

REDASH_URL="http://$ANALYTICS_SUBDOMAIN-$NAMESPACE.$DOMAIN_NAME"

# Prompt for credentials
echo "Redash URL: $REDASH_URL"
read -p "Enter your Redash username: " USERNAME
read -s -p "Enter your Redash password: " PASSWORD
echo

# Authenticate and retrieve API key
LOGIN_RESPONSE=$(curl -s -X POST "$REDASH_URL/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "email=$USERNAME" \
  --data-urlencode "password=$PASSWORD" \
  -c cookies.txt)

if ! echo "$LOGIN_RESPONSE" | grep -q 'Redirecting'; then
  echo "Login failed! Verify your credentials or URL."
  rm cookies.txt
  exit 1
fi

API_RESPONSE=$(curl -s -X GET "$REDASH_URL/api/users/me" -b cookies.txt)
API_KEY=$(echo "$API_RESPONSE" | jq -r '.api_key')

if [ -z "$API_KEY" ]; then
  echo "Failed to retrieve API key!"
  rm cookies.txt
  exit 1
fi

echo "Redash API Key: $API_KEY"

# Cleanup
rm cookies.txt
