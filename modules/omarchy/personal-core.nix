{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dotfiles;
  inherit (cfg) headless;
  inherit (lib) mkIf;

  chromeWebStore = "https://clients2.google.com/service/update2/crx";
in
{
  programs.chromium.extraOpts = mkIf (!headless) {
    ExtensionInstallForcelist = [
      "dbepggeogbaibhgnhhndojpepiihcmeb;${chromeWebStore}" # Vimium
      "nngceckbapebfimnlniiiahkandclblb;${chromeWebStore}" # Bitwarden
    ];
  };

  # omarchy's qtEnableAdwaita only installs Qt5 adwaita, need Qt6 too
  environment.systemPackages = mkIf (!headless) [ pkgs.adwaita-qt6 ];

  omarchy = {
    bash.enable = false;
    qtEnableAdwaita = true;
  };
}
