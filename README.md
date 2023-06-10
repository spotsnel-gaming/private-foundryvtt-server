Private FoundryVTT server
=========================

**Fight goblins, not unwelcome guests!**


Private Foundry VTT server using [Tailscale](https://tailscale.com). 

This container image enables you to run a private Foundry VTT with an 
emphasis on simplicity. It uses Tailscale to expose this as a private
service on a Tailnet. Instead of fighting configuration and passwords,
you can focus on gaming and fighting goblins.

![](./screenshot.jpg)


Note: you need to have a license key to use FoundryVTT


### Usage
Download and copy the Foundry distribution file to a folder that will be used for the Foundry data folder.

```
$ mkdir -p ~/foundrydata/
# copy file as FoundryVTT*.zip or foundryvtt.zip to ./foundrydata
```

Obtain a Tailscale authentication key from

   https://login.tailscale.com/admin/settings/keys


Depending on your needs, set the expiration of the key, if it tags the node, etc. Make sure the ACL is set to allow access to other people in your tailnet.

After this, you can run the container. Be sure to set the `TAILSCALE_AUTH_KEY` value


```
$ podman run -d \
   --name=foundryvtt \
   -v ~/foundrydata:/data \
   --env=TAILSCALE_AUTH_KEY=tskey-auth-... \
   ghcr.io/spotsnel-gaming/private-foundryvtt-server:main
```

If the node joined your tailnet, it should show up as `foundryvtt` in:

    https://login.tailscale.com/admin/machines

after which you can navigate to:

    http://foundryvtt

and finish the configuration or log in.


##### Note

This image is available in both `x86_64` (AMD64) and `aarch64` (arm64) format. If you have issues during deployment, you can use the `--platform=linux/amd64` or `--platform=linux/arm64` to force a specific platform.

These images have been tested on various cloud providers, such as AWS, and Oracle Cloud.


### Systemd
After this you can use systemd to maintain the state of the container
```
$ (cd $HOME/.config/systemd/user && podman generate systemd --name --files foundryvtt)
$ systemctl --user enable --now container-foundryvtt
$ loginctl enable-linger [username]
```

You can check the state of the container with:
```
 $systemctl --user status container-foundryvtt
```


### Build
To build the `Dockerfile`, please do:

```
$ podman build -t foundryvtt .
```

and use `podman run ... foundryvtt` instead.


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

[![PayPal Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=me%40gbraad%2enl&lc=US&item_name=gbraad&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHosted)
