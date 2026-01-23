{ lib, osConfig, ... }:
let
  cfg = osConfig.dotfiles;
in
{
  config = lib.mkIf cfg.virtManager {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
