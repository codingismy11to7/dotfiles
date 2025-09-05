#!/usr/bin/env fish

# used in config.fish
set -Ux NODE_VERSION 22.19.0

# if it's already installed this acts as `nvm use`
nvm install $NODE_VERSION

echo "Ensuring SDKMAN! is installed..."
echo y | sdk > /dev/null; true
