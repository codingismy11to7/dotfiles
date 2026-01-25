{ config, ... }:
{
  # Accept unsigned store paths from the host via nh os boot --target-host
  nix.settings.require-sigs = false;
  security.sudo.wheelNeedsPassword = false;
  home-manager.users.${config.dotfiles.personal.username} = {
    omarchy = {
      terminal = "kitty";
      hyprland = {
        monitorConfig = ''
          env = GDK_SCALE,1
          monitor=Virtual-1,1920x1080,auto,1
        '';
        widerWindowGaps = false;
        dwindleExtra = "single_window_aspect_ratio = 4 3";
      };
    };
  };

  dotfiles = {
    omarchyTheme = "kanagawa";
    personal.gitEmail = "codingismy11to7@gmail.com";
  };
}
