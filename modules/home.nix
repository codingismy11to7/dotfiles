{ config, inputs, ... }:
let
  cfg = config.dotfiles;

  inherit (cfg) username;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = { inherit inputs config; };

    users.${username} = {
      imports = [
        ./secrets/home.nix
      ];

      home = {
        inherit username;
        homeDirectory = "${config.users.defaultUserHome}/${username}";
        stateVersion = "25.11";
      };
    };
  };
}
