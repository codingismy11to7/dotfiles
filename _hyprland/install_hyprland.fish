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
