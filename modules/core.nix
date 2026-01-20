{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./boot/core.nix
    ./fish/core.nix
    ./secrets/core.nix
    ./users/core.nix
  ];
}
