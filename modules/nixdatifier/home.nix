{
  config,
  inputs,
  lib,
  osConfig,
  ...
}:
let
  inherit (osConfig.dotfiles) headless;
in
{
  # Upstream HM module: installs the tray app and, with autostart (default on),
  # writes ~/.config/autostart/nixdatifier.desktop running `nixdatifier --background`.
  imports = [ inputs.nixdatifier.homeManagerModules.default ];

  programs.nixdatifier.enable = !headless;

  # Headless hosts that opt in get just the binary on PATH, to run by hand.
  home.packages = lib.mkIf (headless && osConfig.dotfiles.nixdatifier) [
    config.programs.nixdatifier.package
  ];
}
