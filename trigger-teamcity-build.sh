#!/bin/sh

REPO=$1
TAG=$2
BUILD_TYPE_ID=$3

if [[ "$#" -eq 1 ]]
then
  eval "ARGUMENTS=($1)"
  REPO=${ARGUMENTS[0]}
  TAG=${ARGUMENTS[1]}
  BUILD_TYPE_ID=${ARGUMENTS[2]}
fi

eval "echo \"$(cat ./teamcity_build.xml.tmpl)\"" | curl -X POST "http://teamcity.hypoport.local/teamCity/guestAuth/app/rest/buildQueue" \
     -H "Content-Type: application/xml" \
     -d @-
