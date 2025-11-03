#!/usr/bin/env fish

set -l VERSION 0.2.2

mkdir -p ~/.config/zellij/plugins

cd ~/.config/zellij/plugins/
wget "https://github.com/fresh2dev/zellij-autolock/releases/download/$VERSION/zellij-autolock.wasm"
