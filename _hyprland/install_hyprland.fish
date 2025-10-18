#!/usr/bin/env fish

# basically just trying to record my imperative steps to install hyprland
# here. i know my ssd is dying so i'm trying to make this reproducible on
# my (nvidia) machine


### Installation

# from https://wiki.hypr.land/Nix/Hyprland-on-other-distros/

# > The easiest method is to get Hyprland directly from Nixpkgs:
nix profile add nixpkgs#hyprland

# > Since you’re using Hyprland outside of NixOS, it won’t be able to find graphics drivers.
# > To get around that, you can use nixGL.

# i installed this but...i don't _think_ i need it
# going to comment it out unless i find out i do
#
# nix profile add github:guibou/nixGL --impure

# > --impure is needed due to nixGL’s reliance on hardware information.

# > From now on, you can run Hyprland by invoking it with nixGL.
# > ```
# > nixGL Hyprland
# > ````
#> Or by creating a wrapper script that runs the above command inside.



nix profile add nixpkgs#uwsm



# ok so this is actually turning into install_omarchy?
# i tried it out and liked it so i believe i will start with it
# as a base
# i know there's https://github.com/henrysipp/omarchy-nix but
# i'm not on nixos and don't want to switch to home-manager so
# i'm thinking it's better for me to just check out omarchy confs
# and do it myself

nix profile add nixpkgs#neovim
nix profile add nixpkgs#walker

# errors because of stuff i already have installed, so add lower priority
nix profile add ~/.local/share/chezmoi/_hyprland/omarchyDeps --priority 10


# i think this is just used in omarchy installer and don't need it, but
# it's kind of cool (nm it is used)
# also there's def a way to add this to the flake just don't wanna take
# the time to figure it out right now

nix profile add github:ChrisBuilds/terminaltexteffects/release-0.12.1


## this may be the command to start the de i think
# uwsm start -- hyprland.desktop


# installed these with dnf, scripts were hardcoded to
# /usr/share for yaru, and gtk didn't pick up my nix-installed
# gtk-themes-extra package. or maybe it did but i couldn't tell
# the difference between the themes. whatever.
## dnf install yaru-icon-theme
## dnf install gnome-themes-extra



# ok i'm now realizing that i should be cloning omarchy to my home directory
# and making my changes on top of it. i'm so stupid.

# git clone --recursive --branch v3.0.2 https://github.com/basecamp/omarchy.git ~/.local/share/omarchy
# pushd ~/.local/share/omarchy
# git switch -c hyprismy11to7
# popd


# moved to flake
nix profile remove walker
nix profile remove uwsm


# ╰─❯ dnf install liberation-fonts-all
# Updating and loading repositories:
# Repositories loaded.
# Package "liberation-fonts-all-1:2.1.5-13.fc42.noarch" is already installed.


nix profile remove terminaltexteffects



# forked
git clone --recursive --branch hyprismy11to7 https://github.com/codingismy11to7/omarchy.git ~/.local/share/omarchy


# was just experimenting with nix's kitty and it would not run
# and it turns out that the docs were correct and i do need this
nix profile add github:guibou/nixGL --impure
