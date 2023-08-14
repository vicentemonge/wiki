#!/bin/bash

# Set your API token and project slug
PROJECT_SLUG=vmongewiki
VERSION_SLUG=latest
API_TOKEN=11e0dd38aa17613860ff95a5b6cc9ec3a4dd61b4

# Initialize an empty array to store all builds
all_builds=()

# Start with the first page
next_page="https://readthedocs.org/api/v3/projects/$PROJECT_SLUG/builds/"

# Loop through pagination
while [ "$next_page" != "null" ]; do
    echo "$next_page"
    builds_response=$(curl -s -H "Authorization: Token $API_TOKEN" "$next_page")
    next_page=$(echo "$builds_response" | jq -r '.next')
    builds=$(echo "$builds_response" | jq -c '.results[]')
    all_builds+=($builds)
done

# Print all build entries
for build in "${all_builds[@]}"; do
    echo "$build"
done
