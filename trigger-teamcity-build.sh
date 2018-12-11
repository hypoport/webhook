#!/bin/sh

REPO=$1
TAG=$2
BUILD_TYPE_ID=$3
TEAMCITY_BASE_URL="http://teamcity.hypoport.local/teamCity"

if [[ "$#" -eq 1 ]]
then
  REPO=$(echo $1 | cut -d\  -f1)
  TAG=$(echo $1 | cut -d\  -f2)
  BUILD_TYPE_ID=$(echo $1 | cut -d\  -f3)
fi

eval "echo \"$(cat ./teamcity_build.xml.tmpl)\"" | curl -X POST "${TEAMCITY_BASE_URL}/guestAuth/app/rest/buildQueue" \
     -H "Content-Type: application/xml" \
     -d @-
