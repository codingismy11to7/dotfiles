{ lib, osConfig, pkgs, ... }:
let
  cfg = osConfig.dotfiles;
  inherit (cfg) headless gaming;
  inherit (lib) mkIf;

  stablePackages = with pkgs; [
    diffutils
    ffmpeg
    findutils
    flac
    lame
    unrar
    unzip
    wl-clipboard # wsl is "headless" but needs to copy to wayland
    zip
  ];

  unstablePackages = with pkgs.unstable; [
    fzf
    yt-dlp
  ];

  guiPackages =
    if headless then
      [ ]
    else
      with pkgs.unstable;
      [
        bitwarden-desktop
        brave
        discord
        slack
      ];

  gamingPackages =
    if gaming then
      with pkgs.unstable; [ wowup-cf ]
    else
      [ ];
in
{
  home.packages = stablePackages ++ unstablePackages ++ guiPackages ++ gamingPackages;

  # Workaround: brave ships com.brave.Browser.desktop with NoDisplay=true
  # misplaced under a [Desktop Action] section instead of [Desktop Entry],
  # causing walker to show a duplicate entry. This override can be removed
  # once the packaging bug is fixed upstream.
  xdg.desktopEntries."com.brave.Browser" = mkIf (!headless) {
    name = "Brave Web Browser";
    exec = "brave %U";
    noDisplay = true;
  };

  programs.yazi.enable = true;
}
