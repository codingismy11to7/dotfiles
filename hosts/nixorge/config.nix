{ config, ... }: {
  home-manager.users.${config.dotfiles.personal.username}.omarchy.hyprland.monitorConfig = ''
    env = GDK_SCALE,1.5
    monitor=,preferred,auto,1.6,bitdepth,10
  '';

  dotfiles = {
    gaming = true;
    personal.gitEmail = "codingismy11to7@gmail.com";
  };
}
