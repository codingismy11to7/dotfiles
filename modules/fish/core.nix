{ config, pkgs, ... }:
let
  cfg = config.dotfiles;
  inherit (cfg) username;
in
{
  users.users.${username}.shell = pkgs.fish;

  programs = {
    fish = {
      enable = true;
      useBabelfish = true;
    };
  };
}
