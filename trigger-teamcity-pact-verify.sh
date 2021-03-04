#!/bin/sh

BUILD_TYPE_ID="$1"
ADDITIONAL_PAYLOAD=$(echo "$2" | base64)
TEAMCITY_BASE_URL="http://teamcity.hypoport.local/teamCity"

if [[ "$#" -eq 1 ]]
then
  BUILD_TYPE_ID=$(echo $1 | cut -d\  -f1)
  ADDITIONAL_PAYLOAD=$(echo $1 | cut -d\  -f2 | base64)
fi

#echo "BUILD_TYPE_ID: $BUILD_TYPE_ID"
#echo "ADDITIONAL_PAYLOAD: $ADDITIONAL_PAYLOAD"

#cat ./teamcity_build.xml | curl -X POST "${TEAMCITY_BASE_URL}/guestAuth/app/rest/buildQueue" \
#     -H "Content-Type: application/xml" \
#     -d @-
eval "echo \"$(cat ./teamcity_build.xml.tmpl)\"" | curl -X POST "${TEAMCITY_BASE_URL}/guestAuth/app/rest/buildQueue" \
     -H "Content-Type: application/xml" \
     -d @-
