#!/bin/bash

REPO=$1
TAG=$2
BUILD_TYPE_ID=$3

# todo in-memory behalten, falls viele Requests reinkommen
eval "echo \"$(cat ./teamcity_build.xml.tmpl)\"" > ./teamcity_build.xml
curl -X POST "http://teamcity.hypoport.local/teamCity/guestAuth/app/rest/buildQueue" -H "Content-Type: application/xml" -d@teamcity_build.xml
