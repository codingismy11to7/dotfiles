{ config, pkgs, ... }:
{
  # CD ripper with AccurateRip verification
  environment.systemPackages = [ pkgs.whipper ];

  home-manager.users.${config.dotfiles.personal.username}.omarchy = {
    media.sensitiveVolume = true;
    hyprland.monitorConfig = ''
      hl.env("GDK_SCALE", "1.5")
      hl.monitor({ output = "DP-2", mode = "5120x2160@165", position = "0x0", scale = 1.6, bitdepth = 10, cm = "hdr", sdrbrightness = 1.35 })
      hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.6, bitdepth = 10 })
      -- render:cm_fs_passthrough was removed in Hyprland 0.55 (automatic via cm_auto_hdr).
    '';
  };

  dotfiles = {
    gaming = true;
    kernel = "zen";
    videoEncoding = true;
    personal.gitEmail = "codingismy11to7@gmail.com";
  };
}
