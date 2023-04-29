Private FoundryVTT server
=========================


Private Foundry VTT server using caddy-tailscale


### Usage

Download and copy the Foundry distribution file to a folder that will be used for the Foundrydata

```
$ mkdir -p ./foundrydata/
# copy file as FoundryVTT*.zip or foundryvtt.zip to ./foundrydata
```

Obtain a Tailscale authentication key from

   https://login.tailscale.com/admin/settings/keys

Depending on your needs, set the expiration of the key, if it tags the node, etc.

After this you can run the container. Be sure to set the `TS_AUTHKEY` value


```
$ podman run -it \
   -v ./foundrydata:/data
   --env=TS_AUTHKEY=tskey-auth-...
   ghcr.io/spotsnel/caddy-tailscale-foundryvtt-server
```
