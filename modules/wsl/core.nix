{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dotfiles;
  inherit (lib) mkIf;
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  config = mkIf cfg.wsl {
    wsl = {
      enable = true;
      useWindowsDriver = true;
      defaultUser = cfg.personal.username;
      interop.register = true;
    };

    environment.systemPackages = with pkgs; [
      wsl-open
      xdg-utils
    ];

    nixpkgs.overlays = [
      (_final: prev: {
        xdg-utils = prev.symlinkJoin {
          name = "xdg-utils-wsl";
          paths = [ prev.xdg-utils ];
          postBuild = ''
            ln -sf ${prev.wsl-open}/bin/wsl-open $out/bin/xdg-open
          '';
        };
      })
    ];
  };
}
