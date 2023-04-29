#!/bin/sh

# extract foundryvtt.zip or FoundryVTT*.zip to /app/

# if not exists /app/resources/app/main/js
appready=false
main=/app/resources/app/main.js

if [ -e "$main" ]
then
    echo "READY!"
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
    node $main --headless --dataPath=/data/ &
    caddy run --config /app/Caddyfile
else
    echo "App not ready. Unable to start"
    exit 1
fi
