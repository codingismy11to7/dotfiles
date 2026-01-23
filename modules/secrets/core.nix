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
    inherit (cfg.personal) username;
    users.enable = true;
    enableGithubToken = true;
  };
}
