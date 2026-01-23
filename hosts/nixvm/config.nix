{ config, ... }: {
  home-manager.users.${config.dotfiles.personal.username}.omarchy.hyprland = {
    monitorConfig = ''
      env = GDK_SCALE,1
      monitor=Virtual-1,1920x1080,auto,1
    '';
    widerWindowGaps = false;
    dwindleExtra = "single_window_aspect_ratio = 4 3";
  };

  dotfiles = {
    personal.gitEmail = "codingismy11to7@gmail.com";
  };
}
