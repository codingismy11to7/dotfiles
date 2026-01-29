{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (cfg) videoEncoding;
  inherit (lib) mkIf optionals;
in
mkIf videoEncoding {
  home.packages =
    [ pkgs.handbrake ]
    ++ optionals (pkgs.stdenv.hostPlatform.system == "x86_64-linux") [ pkgs.makemkv ];
}
