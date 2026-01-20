{ inputs, ... }:
{
  imports = [
    inputs.secrets.homeManagerModules.default
  ];

  secrets.enable = true;
}
