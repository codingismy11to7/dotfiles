{ config, ... }:
let
  inherit (config) fullName username;
in
{
  users = {
    mutableUsers = false;

    users.${username} = {
      isNormalUser = true;
      description = fullName;
      extraGroups = [
        "wheel"
      ];
    };
  };
}
