{
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles;
in
{
  config = lib.mkIf cfg.virtManager {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.users.${cfg.personal.username}.extraGroups = [ "libvirtd" ];
  };
}
