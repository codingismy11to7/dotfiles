{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = [
      "com.dosbox_x.DOSBox-X"
      "com.github.tchx84.Flatseal"
      "io.anytype.anytype"
      "io.github.dosbox-staging"
    ];
    update.onActivation = true;
  };
}
