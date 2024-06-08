# Discord updater for linux (Distro independent)

A simple bash script to auto update discord before launch, as the linux release of Discord doesn't support auto updating itself.

The script launches Discord after checking for updates, so you can update existing Discord shortcuts/login scripts to run this script instead of Discord directly.

All command line arguments are passed onto Discord.

i.e. The following will pass the `--enable-features=UseOzonePlatform --ozone-platform=wayland` arguments to the launched Discord instance to enforce use of the wayland compositor:

```bash
discord_updater.sh --enable-features=UseOzonePlatform --ozone-platform=wayland
```

## Dependencies

* wget
* curl