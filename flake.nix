{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
      # url = "path:/home/steven/dev/nvim";
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

    claude-code-nix = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    codex-cli-nix = {
      url = "github:sadjow/codex-cli-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    omarchy = {
      url = "github:codingismy11to7/omarchy";
      # url = "path:/home/steven/dev/omarchy";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
        home-manager.follows = "home-manager";
        claude-code-nix.follows = "claude-code-nix";
        codex-cli-nix.follows = "codex-cli-nix";
      };
    };

    stylix = {
      url = "github:danth/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.55.4";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      systems,
      ...
    }:
    with builtins;
    let
      hostsDir = readDir ./hosts;
      hosts = filter (n: hostsDir.${n} == "directory") (attrNames hostsDir);
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
                deadnix
                nixd
                statix
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
                (writeShellScriptBin "vm-deploy" (
                  readFile (
                    replaceVars ./.scripts/vm-deploy {
                      gum = getExe gum;
                      rsync = getExe rsync;
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
