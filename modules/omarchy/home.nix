{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (lib) mkDefault;
  inherit (cfg)
    headless
    keyboardLayout
    keyboardVariant
    ;
in
{
  imports = [
    inputs.omarchy.homeManagerModules.default
  ];

  omarchy = {
    enable = !headless;
    theme = mkDefault "ethereal";
    firstRunMode = mkDefault false;
    browser.webapp = mkDefault pkgs.unstable.microsoft-edge;
    font.name = mkDefault "FiraCode Nerd Font";
    font.package = mkDefault pkgs.nerd-fonts.fira-code;
    keyboard = {
      layout = mkDefault keyboardLayout;
      variant = mkDefault keyboardVariant;
      options = mkDefault "compose:ralt";
    };
    hyprland = {
      package = mkDefault pkgs.unstable.hyprland;
      widerWindowGaps = mkDefault true;
      dwindleExtra = mkDefault "single_window_aspect_ratio = 16 9";
    };
    passwordManager = mkDefault "bitwarden";
    screensaver = {
      activationSeconds = mkDefault 300;
      lockSeconds = mkDefault 900;
      screenOffSeconds = mkDefault 960;
    };
  };
}
