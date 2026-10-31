{
  config,
  inputs,
  lib,
  ...
}:
with builtins;
let
  inherit (config.boot.kernelPackages) callPackage;
  inherit (inputs) nixpkgs-unstable;
  inherit (lib.modules) mkIf;

  nvidiaPackages = callPackage "${nixpkgs-unstable}/pkgs/os-specific/linux/nvidia-x11" { };

  graphics = config.hardware.facter.report.hardware.graphics_card or [ ];
  hasNvidia = any (g: g.driver or "" == "nvidia") graphics;
in
{
  config = mkIf hasNvidia {
    boot.initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      package = nvidiaPackages.production;
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
    };
  };
}
