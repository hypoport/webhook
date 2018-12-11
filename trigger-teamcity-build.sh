#!/bin/ash

REPO=$1
TAG=$2
BUILD_TYPE_ID=$3

eval "echo \"$(cat ./teamcity_build.xml.tmpl)\"" | curl -X POST "http://teamcity.hypoport.local/teamCity/guestAuth/app/rest/buildQueue" \
     -H "Content-Type: application/xml" \
     -d @-
