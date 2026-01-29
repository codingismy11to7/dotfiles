{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (cfg) videoEncoding;
  inherit (lib) mkIf;
in
mkIf videoEncoding {
  home.packages = [ pkgs.handbrake ];
}
