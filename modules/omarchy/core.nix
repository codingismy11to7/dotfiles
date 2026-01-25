{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dotfiles;
  inherit (cfg) headless personal;
  inherit (personal) username;
in
{
  imports = [
    inputs.omarchy.nixosModules.default
  ];

  omarchy = {
    enable = !headless;
    hyprland = {
      package = pkgs.unstable.hyprland;
      portalPackage = pkgs.unstable.xdg-desktop-portal-hyprland;
    };
    qtEnableAdwaita = true;
    gaming = lib.mkIf cfg.gaming {
      steam = true;
      steamRealtime = true;
      heroicGameLauncher = true;
    };
    inherit username;
  };
}
