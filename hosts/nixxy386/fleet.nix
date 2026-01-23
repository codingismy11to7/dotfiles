{ inputs, ... }:
{
  imports = [
    inputs.fleet.nixosModules.gitlab
  ];

  services.fleet.enable = true;
}
