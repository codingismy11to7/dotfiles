{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
# Tauri build from plexamp-nix; nixpkgs' plexamp is the old Electron 4.13.2,
# which crashes on NVIDIA + Wayland (NixOS/nixpkgs#400425).
mkIf (!osConfig.dotfiles.headless) {
  home.packages = [ inputs.plexamp.packages.${pkgs.stdenv.hostPlatform.system}.plexamp ];
}
