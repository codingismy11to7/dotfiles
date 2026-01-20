{ config, inputs, ... }:
let
  cfg = config.dotfiles;
in
{
  imports = [
    inputs.secrets.nixosModules.default
  ];

  secrets = {
    enable = true;
    inherit (cfg) username;
    users.enable = true;
    enableGithubToken = true;
  };
}
