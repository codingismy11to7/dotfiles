{
  config,
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
if headless then
  { }
else
  let
    browserPkg = pkgs.unstable.${cfg.browser};
  in
  {
    imports = [
      inputs.omarchy.homeManagerModules.default
    ];

    omarchy = {
    enable = true;
    theme = mkDefault cfg.omarchyTheme;
    firstRunMode = mkDefault false;
    packages = {
      inherit (pkgs.unstable) fastfetch obsidian;
    };
    browser.webapp = mkDefault (config.omarchy.browser.wrapWithExtension browserPkg);
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
    ai.claudeCode.enable = mkDefault true;
    passwordManager = mkDefault "bitwarden";
    screensaver = {
      activationMinutes = mkDefault 5;
      lockMinutes = mkDefault 15;
      screenOffDelaySeconds = mkDefault 60;
    };
    webapps = {
      basecamp.enable = mkDefault false;
      chatgpt.enable = mkDefault false;
      discord.enable = mkDefault false;
      figma.enable = mkDefault false;
      fizzy.enable = mkDefault false;
      plex.enable = mkDefault true;
      whatsapp.enable = mkDefault false;
      x.enable = mkDefault false;
      custom = {
        Radarr = {
          url = "https://radarr.codingismy11to7.us";
          icon = ./icons/radarr.svg;
          singleton = false;
        };
        SABnzbd = {
          url = "https://sabnzbd.codingismy11to7.us";
          icon = ./icons/sabnzbd.svg;
          singleton = false;
        };
        Sonarr = {
          url = "https://sonarr.codingismy11to7.us";
          icon = ./icons/sonarr.svg;
          singleton = false;
        };
        Synology = {
          url = "https://codingismy11to7.us:50443";
          icon = ./icons/synology.svg;
        };
        Tautulli = {
          url = "https://tautulli.codingismy11to7.us";
          icon = ./icons/tautulli.svg;
          singleton = false;
        };
        Wowhead = {
          url = "https://www.wowhead.com";
          icon = ./icons/wowhead.svg;
          singleton = true;
        };
      };
    };
    # TODO: revisit, voxtype doesn't work properly with dvorak
    # https://github.com/peteonrails/voxtype/issues/120
    # voxtype = {
    #   variant = mkDefault "vulkan";
    #   model = mkDefault "large-v3-turbo";
    #   ydotool = mkDefault pkgs.unstable.ydotool;
    #   audioFeedback = {
    #     theme = mkDefault "subtle";
    #     volume = mkDefault 0.8;
    #   };
    # };
  };
}
