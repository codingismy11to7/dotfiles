{ config, pkgs, ... }:
{
  # CD ripper with AccurateRip verification
  environment.systemPackages = [ pkgs.whipper ];

  home-manager.users.${config.dotfiles.personal.username}.omarchy = {
    media.sensitiveVolume = true;
    hyprland.monitorConfig = ''
      hl.env("GDK_SCALE", "1.5")
      -- HDR left OFF deliberately (2026-07-12). On Hyprland 0.55.4 + NVIDIA 595.71.05
      -- + this panel, 10-bit HDR output gave washed-out/muddy color AND broke
      -- screencopy (screenshots came out frozen, then black/transparent); SDR is
      -- vibrant and screenshots work. Revisit when NVIDIA/Hyprland Wayland HDR matures.
      -- To re-enable, swap the two SDR lines below for these:
      -- hl.monitor({ output = "DP-2", mode = "5120x2160@165", position = "0x0", scale = 1.6, bitdepth = 10, cm = "hdr", sdrbrightness = 1.35 })
      -- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.6, bitdepth = 10 })
      hl.monitor({ output = "DP-2", mode = "5120x2160@165", position = "0x0", scale = 1.6 })
      hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.6 })
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
