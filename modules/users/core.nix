{ config, ... }:
let
  cfg = config.dotfiles;
  inherit (cfg.personal) fullName username;
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = fullName;
    extraGroups = [
      "wheel"
    ];
  };
}
