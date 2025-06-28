#!/bin/bash

# Exit on error
set -e

echo "Adding Spotify repository and installing Spotify..."

# Ensure dependencies are installed
sudo apt update
sudo apt install -y curl gnupg2 software-properties-common

# Add Spotify's public key
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/spotify.gpg > /dev/null

# Add Spotify's repository
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Update package list
sudo apt update

# Install Spotify
sudo apt install -y spotify-client

echo "✅ Spotify installation complete!"
