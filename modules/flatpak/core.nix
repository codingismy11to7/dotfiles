{ config, inputs, lib, ... }:
let
  cfg = config.dotfiles;
in
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = !cfg.headless;
    packages = [
      "com.github.tchx84.Flatseal"
      "io.anytype.anytype"
    ] ++ lib.optionals cfg.gaming [
      "com.dosbox_x.DOSBox-X"
      "io.github.dosbox-staging"
      "org.DolphinEmu.dolphin-emu"
    ];
    update.onActivation = true;
  };
}
