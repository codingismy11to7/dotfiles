{ config, lib, ... }:
with builtins;
let
  inherit (lib.modules) mkIf;

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
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
    };
  };
}
