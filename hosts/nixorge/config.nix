{ config, pkgs, ... }:
{
  # CD ripper with AccurateRip verification
  environment.systemPackages = [ pkgs.whipper ];

  home-manager.users.${config.dotfiles.personal.username}.omarchy = {
    media.sensitiveVolume = true;
    hyprland.monitorConfig = ''
      env = GDK_SCALE,1.5
      monitor = DP-2, 5120x2160@165, 0x0, 1.6, bitdepth, 10, cm, hdr, sdrbrightness, 1.35
      monitor=,preferred,auto,1.6,bitdepth,10

      render {
          cm_fs_passthrough = 1
      }
    '';
  };

  dotfiles = {
    gaming = true;
    kernel = "zen";
    videoEncoding = true;
    personal.gitEmail = "codingismy11to7@gmail.com";
  };
}
