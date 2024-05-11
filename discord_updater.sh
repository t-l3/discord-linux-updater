#!/bin/bash

DISPLAY_BACKUP=$DISPLAY;
unset DISPLAY;

DISCORD_DOWNLOAD_URL='https://discord.com/api/download?platform=linux&format=tar.gz';

discord_version_grep() {
  grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1;
}

mkdir -p ~/.discord

if [ ! -f ~/.discord/version ]; then
  env DISPLAY="discordupdater.fake.display" ~/.discord/Discord --version 2>&1 | head -n 1 | discord_version_grep > ~/.discord/version;
fi

AVAILABLE_VERSION=$(curl -s $DISCORD_DOWNLOAD_URL | discord_version_grep); # curl prints http redirect
INSTALLED_VERSION=$(cat ~/.discord/version);

if [ "$AVAILABLE_VERSION" != "$INSTALLED_VERSION" ]; then
  echo "New version of Discord is available. Downloading..."
  mkdir ~/discord_update_tmp;
  cd ~/discord_update_tmp;
  wget -O discord_install.tar.gz $DISCORD_DOWNLOAD_URL; # wget follows redirect and downloads file
  tar -xzf ./discord_install.tar.gz;
  rm -rf ~/.discord/*;
  mv ./Discord/* ~/.discord/;
  cd ~;
  rm -rf ~/discord_update_tmp;
else
  echo "Discord is already latest version."
fi

export DISPLAY=$DISPLAY_BACKUP
~/.discord/Discord
