{
  config,
  inputs,
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
    inherit username;
  };
}
