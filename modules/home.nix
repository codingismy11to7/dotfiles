{ config, inputs, ... }:
let
  cfg = config.dotfiles;

  inherit (cfg.personal) username;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = { inherit inputs; };

    users.${username} = {
      imports = [
        ./claude/home.nix
        ./direnv/home.nix
        ./face-melter/home.nix
        ./fish/home.nix
        ./lazygit/home.nix
        ./nix-your-shell/home.nix
        ./n64RecompLauncher-bin/home.nix
        ./nvim/home.nix
        ./omarchy/home.nix
        ./packages/home.nix
        ./podman/home.nix
        ./secrets/home.nix
        ./services/home.nix
        ./syncthing/home.nix
        ./stylix/home.nix
        ./tealdeer/home.nix
        ./video-encoding/home.nix
        ./virt-manager/home.nix
        ./zellij/home.nix
      ];

      home = {
        inherit username;
        homeDirectory = "${config.users.defaultUserHome}/${username}";
        stateVersion = "25.11";
      };
    };
  };
}
