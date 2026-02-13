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
  inherit (lib) mkDefault mkIf mkMerge;
  inherit (cfg)
    headless
    keyboardLayout
    keyboardVariant
    ;
  browserPkg = pkgs.unstable.${cfg.browser};
in
{
  imports = [
    inputs.omarchy.homeManagerModules.default
  ];

  omarchy = {
    ai.claudeCode.enable = mkDefault true;

    git = {
      userName = mkDefault cfg.personal.fullName;
      userEmail = mkDefault cfg.personal.gitEmail;
    };

    # Disable GUI components when headless
    hyprland.enable = !headless;
    terminal = if headless then null else mkDefault "ghostty";

    theme = mkDefault cfg.omarchyTheme;
    firstRunMode = mkDefault false;
    packages = mkMerge [
      { inherit (pkgs.unstable) fzf git; }
      (mkIf (!headless) {
        inherit (pkgs.unstable) fastfetch obsidian;
      })
      (mkIf headless {
        imv = null;
        mpv = null;
        swayosd = null;
      })
    ];
    browser.webapp = mkIf (!headless) (mkDefault (config.omarchy.browser.wrapWithExtension browserPkg));
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
    webapps = mkIf (!headless) {
      basecamp.enable = mkDefault false;
      chatgpt.enable = mkDefault false;
      discord.enable = mkDefault false;
      figma.enable = mkDefault false;
      fizzy.enable = mkDefault false;
      plex.enable = mkDefault true;
      youtube-music.enable = mkDefault true;
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
