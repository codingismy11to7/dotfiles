{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (cfg) headless gaming;
  inherit (lib) mkIf;

  browserPkg = pkgs.unstable.${cfg.browser};

  stablePackages = with pkgs; [
    diffutils
    ffmpeg
    file
    findutils
    flac
    lame
    sshfs
    unrar
    unzip
    wget
    wl-clipboard # wsl is "headless" but needs to copy to wayland
    zip
  ];

  # TEMPORARY: nixpkgs is on obscura 0.2.0, which strands the page between MCP
  # tool calls. Drop this and uncomment the one-liner below once nixpkgs is on
  # 0.2.1 or newer. See obscura-0.2.1.nix.
  obscuraWithMcpFix = pkgs.unstable.callPackage ./obscura-0.2.1.nix { };

  unstablePackages = with pkgs.unstable; [
    fzf
    # obscura # headless/mcp browser
    obscuraWithMcpFix
    yt-dlp
  ];

  guiPackages =
    if headless then
      [ ]
    else
      with pkgs.unstable;
      [
        bitwarden-desktop
        (config.omarchy.browser.wrapWithExtension browserPkg)
        discord
        feishin
        slack
      ];

  gamingPackages = if gaming then with pkgs.unstable; [ wowup-cf ] else [ ];
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

  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
  };
}
