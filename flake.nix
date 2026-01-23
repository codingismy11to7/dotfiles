{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      url = "github:codingismy11to7/secrets";
      inputs = {
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nvim = {
      url = "github:codingismy11to7/nvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sentinelone = {
      url = "github:codingismy11to7/sentinelone-nix";
      inputs.flake-parts.follows = "flake-parts";
    };

    fleet = {
      url = "github:codingismy11to7/fleetdm-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    omarchy = {
      url = "github:codingismy11to7/omarchy";
      # url = "path:/home/steven/dev/omarchy";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    inputs@{
      disko,
      flake-parts,
      systems,
      ...
    }:
    with builtins;
    let
      hosts = [
        "nixorge"
        "nixvm"
        "nixxy386"
      ];
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      # ---------------------------------------------------------
      # Per-System Logic (DevShells, Formatters, Package Checks)
      # ---------------------------------------------------------
      perSystem =
        { pkgs, ... }:
        {
          devShells.default =
            let
              inherit (pkgs) lib replaceVars writeShellScriptBin;
              inherit (lib) getExe;
            in
            pkgs.mkShell {
              packages = with pkgs; [
                nixd
                uv

                (writeShellScriptBin "deploy" (
                  readFile (
                    replaceVars ./.scripts/deploy {
                      git = getExe git;
                      gum = getExe gum;
                      nixosAnywhere = getExe nixos-anywhere;
                    }
                  )
                ))
                (writeShellScriptBin "dev-mode" (
                  readFile (
                    replaceVars ./.scripts/dev-mode {
                      nh = getExe nh;
                      watchexec = getExe watchexec;
                    }
                  )
                ))
              ];
            };

          formatter = pkgs.nixfmt;
        };

      # ---------------------------------------------------------
      # Global Logic (NixOS Configurations, Modules)
      # ---------------------------------------------------------
      flake =
        let
          mkNixosConfig =
            host:
            inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                ./modules/core.nix
                ./modules/home.nix
                ./modules/options.nix
                ./hosts/${host}
                { networking.hostName = host; }
              ];
            };
        in
        {
          nixosConfigurations = listToAttrs (
            map (host: {
              name = host;
              value = mkNixosConfig host;
            }) hosts
          );
        };
    };
}
