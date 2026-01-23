{
  inputs,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (cfg)
    headless
    keyboardLayout
    keyboardVariant
    monitorConfig
    ;
in
{
  imports = [
    inputs.omarchy.homeManagerModules.default
  ];

  omarchy = {
    enable = !headless;
    theme = "ethereal";
    firstRunMode = false;
    browser.webapp = pkgs.unstable.microsoft-edge;
    font.name = "FiraCode Nerd Font";
    font.package = pkgs.nerd-fonts.fira-code;
    keyboard = {
      layout = keyboardLayout;
      variant = keyboardVariant;
      options = "compose:ralt";
    };
    hyprland = {
      package = pkgs.unstable.hyprland;
      inherit monitorConfig;
      widerWindowGaps = true;
      dwindleExtra = "single_window_aspect_ratio = 16 9";
    };
    passwordManager = "bitwarden";
    screensaver = {
      activationMinutes = 5;
      lockMinutes = 15;
      screenOffDelaySeconds = 60;
    };
  };
}
