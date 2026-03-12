{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dotfiles;
  inherit (cfg) headless;
  inherit (cfg.personal) username;
  inherit (lib) mkIf;
in
{
  imports = [
    inputs.omarchy.nixosModules.default
    ./personal-core.nix
  ];

  omarchy = {
    enable = !headless;
    hyprland = {
      package = pkgs.unstable.hyprland;
      portalPackage = pkgs.unstable.xdg-desktop-portal-hyprland;
    };
    gaming = mkIf cfg.gaming {
      enable = true;
      steam = true;
      steamRealtime = true;
      heroicGameLauncher = true;
    };
    inherit username;
  };
}
