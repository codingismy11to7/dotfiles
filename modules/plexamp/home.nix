{ lib, pkgs, ... }:
let
  inherit (lib) optionals;
  inherit (pkgs.stdenv.hostPlatform) isx86_64;
in
{
  home.packages = optionals isx86_64 [
    pkgs.plexamp
  ];
}
