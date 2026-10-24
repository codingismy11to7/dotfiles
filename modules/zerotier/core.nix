{ config, lib, ... }:
let
  cfg = config.dotfiles;
  inherit (lib) mkIf;
in
{
  config = mkIf (cfg.zerotier.networks != [ ]) {
    services.zerotierone = {
      enable = true;
      joinNetworks = cfg.zerotier.networks;
    };
  };
}
