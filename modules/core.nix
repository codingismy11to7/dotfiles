{ config, inputs, ... }:
let
  bareMetal = config.hardware.facter.detected.virtualisation.none.enable;
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ./boot/core.nix
    ./fish/core.nix
    ./flatpak/core.nix
    ./locale/core.nix
    ./nh/core.nix
    ./nix/core.nix
    ./nvidia/core.nix
    ./omarchy/core.nix
    ./overlays/core.nix
    ./podman/core.nix
    ./secrets/core.nix
    ./ssh/core.nix
    ./stylix/core.nix
    ./users/core.nix
    ./virt-manager/core.nix
    ./wsl/core.nix
    ./face-melter/core.nix
  ];

  hardware.bluetooth.enable = config.hardware.facter.report.hardware.bluetooth or [] != [];
  hardware.enableRedistributableFirmware = true;
  services.fstrim.enable = bareMetal;
  services.smartd.enable = bareMetal;

  system.stateVersion = "25.11";
}
