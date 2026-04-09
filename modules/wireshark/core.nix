{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dotfiles;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.wireshark {
    programs.wireshark.enable = true;
    users.users.${cfg.personal.username}.extraGroups = [ "wireshark" ];
    environment.systemPackages = [ pkgs.wireshark ];
  };
}
