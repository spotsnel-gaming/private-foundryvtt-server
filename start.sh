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

    echo 'Starting up Tailscale...'

    /app/tailscaled --verbose=1 --port 41641 --tun=userspace-networking &
    sleep 5
    if [ ! -S /var/run/tailscale/tailscaled.sock ]; then
        echo "tailscaled.sock does not exist. exit!"
        exit 1
    fi

    until /app/tailscale up \
        --authkey=${TAILSCALE_AUTH_KEY} \
        --hostname=foundryvtt \
        --ssh
    do
        sleep 0.1
    done

    echo 'Tailscale serve FoundryVTT proxy...'

    /app/tailscale serve tcp:80 tcp://localhost:30000

    echo 'Tailscale started'

    echo 'Starting up FoundryVTT...'

    while true; do
        node $main --headless --dataPath=/data/
        echo "Restarting FoundryVTT service"
        sleep 2s
    done

else
    echo "App not ready. Unable to start"
    exit 1
fi
