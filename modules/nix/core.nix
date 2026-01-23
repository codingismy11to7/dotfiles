{ config, inputs, ... }:
let
  cfg = config.dotfiles;
  inherit (cfg.personal) username;
in
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    registry.unstable.flake = inputs.nixpkgs-unstable;

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ username ];
      allowed-users = [ username ];
      max-substitution-jobs = 32;
      connect-timeout = 10;

      substituters = [
        "https://nix-proxy.codingismy11to7.us"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
        "https://walker-git.cachix.org"
      ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
  };
}
