Private FoundryVTT server
=========================

**Fight goblins, not unwelcome guests!**


Private Foundry VTT server using caddy-tailscale

![](./screenshot.jpg)


Note: you need to have a license key to use FoundryVTT


### Usage

Download and copy the Foundry distribution file to a folder that will be used for the Foundrydata

```
$ mkdir -p ./foundrydata/
# copy file as FoundryVTT*.zip or foundryvtt.zip to ./foundrydata
```

Obtain a Tailscale authentication key from

   https://login.tailscale.com/admin/settings/keys


Depending on your needs, set the expiration of the key, if it tags the node, etc. Make sure the ACL is set to allow access to othe people in your tailnet.

After this you can run the container. Be sure to set the `TS_AUTHKEY` value


```
$ podman run -d \
   --name=foundryvtt \
   -v ./foundrydata:/data \
   --env=TS_AUTHKEY=tskey-auth-... \
   ghcr.io/spotsnel-gaming/private-foundryvtt-server
```

If the node joined your tailnet, it should show up as `foundryvtt` in:

    https://login.tailscale.com/admin/machines

after which you can navigate to:

    http://foundryvtt

and finish the configuration or login.


##### Note

This image is available in both `x86_64` (AMD64) and `aarch64` (arm64) format. If you have issues on deployment, you can use the `--platform=linux/amd64` or `--platform=linux/arm64` to force a specific platform.


### Build
To build the `Dockerfile`, please do:

```
$ podman build -t foundryvtt .
```

and use `podman run ... foundryvtt` instead.

##### Note
You can rebuild the `caddy-tailscale` with the included `Containerfile`. For this you need to modify the `builder` that is used.


## Author

| [!["Gerard Braad"](http://gravatar.com/avatar/e466994eea3c2a1672564e45aca844d0.png?s=60)](http://gbraad.nl "Gerard Braad <me@gbraad.nl>") |
|---|
| [@gbraad](https://gbraad.nl/social)  |


### Sponsor
Become a patron or sponsor, by simply clicking one of these buttons

[![](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/gbraad)

[![Github Sponsorship](.github/github_sponsor_btn.svg)](https://github.com/sponsors/gbraad)

... or consider a small one-time donation to show appreciation

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/gbraad)

[![PayPal donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=me%40gbraad%2enl&lc=US&item_name=gbraad&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHosted)
