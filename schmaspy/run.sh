#!/bin/bash

echo ${PWD}
rm -fr output/*

docker run -v "${PWD}/output:/output" -v "${PWD}/config:/config" \
       --net="host" \
       schemaspy/schemaspy:latest \
       -configFile /config/schemaspy.properties \
       -imageformat svg -norows -rails -vizjs
