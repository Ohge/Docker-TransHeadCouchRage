#!/bin/bash

### LOAD COMMON COMPONENTS
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/.appvars
source $DIR/.common

### CHECK IF INSTALLED
RES=$(docker ps -a | awk '{print $NF}' | grep $APP)
if ! [[ $RES == *"$APP"* ]]; then echo "Error: $APP not installed for this user"; exit 1; fi

### STOP CONTAINER
RES=$(docker ps -a | grep 'Up' | awk '{print $NF}' | grep $APP)
if [[ $RES == *"$APP"* ]]; then RES=$(docker stop $APP); fi
echo "$APP stopped"

### REMOVE CONTAINER
RES=$(docker rm "$APP")
if [[ $RES == *"$APP"* ]]; then echo "$APP uninstalled";
else echo "$APP was not removed!"; exit 1; fi

### REMOVE UNUSED IMAGES
RES=$(docker ps -a | awk '{print $2}' | grep -c $IMG)
if [ $RES -eq 0 ]; then
  #RES=$(docker rmi "$IMG")
  echo "$IMG uninstalled"
fi

### REMOVE TAGLESS IMAGES
RES=$(docker images | grep "^<none>" | awk '{print $3}' | xargs --no-run-if-empty docker rmi)
REC=$?
exit $REC
