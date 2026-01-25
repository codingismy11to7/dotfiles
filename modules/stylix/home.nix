{
  lib,
  osConfig,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (lib) mkIf mkMerge;
in
{
  # Note: Don't import stylix.homeModules here - the NixOS module propagates settings
  # Image is set at NixOS level in default.nix

  stylix.targets = mkMerge [
    # Headless targets (CLI tools)
    (mkIf cfg.headless {
      fish.enable = true;
    })

    # GUI-specific targets only when not headless
    (mkIf (!cfg.headless) {
      # Targets are configured via stylix.targets.<name>.enable
      # Available targets include: firefox, gtk, qt, kitty, alacritty, etc.
      # See: https://github.com/danth/stylix/tree/release-25.11/modules

      # Enable specific targets here as needed
      # firefox.enable = true;
    })
  ];
}
