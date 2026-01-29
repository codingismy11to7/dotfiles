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

  chromeWebStore = "https://clients2.google.com/service/update2/crx";
in
{
  imports = [
    inputs.omarchy.nixosModules.default
  ];

  programs.chromium.extraOpts = mkIf (!headless) {
    ExtensionInstallForcelist = [
      "dbepggeogbaibhgnhhndojpepiihcmeb;${chromeWebStore}" # Vimium
      "nngceckbapebfimnlniiiahkandclblb;${chromeWebStore}" # Bitwarden
    ];
  };

  # omarchy's qtEnableAdwaita only installs Qt5 adwaita, need Qt6 too
  environment.systemPackages = mkIf (!headless) [ pkgs.adwaita-qt6 ];

  omarchy = {
    enable = !headless;
    hyprland = {
      package = pkgs.unstable.hyprland;
      portalPackage = pkgs.unstable.xdg-desktop-portal-hyprland;
    };
    qtEnableAdwaita = true;
    gaming = mkIf cfg.gaming {
      enable = true;
      steam = true;
      steamRealtime = true;
      heroicGameLauncher = true;
    };
    inherit username;
  };
}
