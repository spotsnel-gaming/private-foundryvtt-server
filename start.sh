#!/bin/sh

# extract foundryvtt.zip or FoundryVTT*.zip to /app/

# if not exists /app/resources/app/main/js
appready=false
if [ -e /app/resources/app/main.js ]
then
    appready=true
else

    if [ -e /data/foundryvtt.zip ]
    then
        unzip /data/foundryvtt.zip -d /app
	appready=true
    fi    

    if [ -e /data/FoundryVTT*.zip ]
    then
        unzip /data/FoundryVTT*.zip -d /app
	appready=true
    fi    
    
fi

if [ "$appready" = true ]
then
    node /app/resources/app/main.js --headless --dataPath=/data/
else
    echo "App not ready. Unable to start"
    exit 1
fi
