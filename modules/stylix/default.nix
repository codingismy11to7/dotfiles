{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.dotfiles;
  omarchyTheme = inputs.omarchy.stylixTheme {
    theme = cfg.omarchyTheme;
    inherit lib;
  };
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = lib.mkIf (!cfg.headless) {
    enable = true;
    autoEnable = false;

    # Dark or light based on omarchy theme
    polarity = omarchyTheme.polarity;

    # Always set image (used as wallpaper and for color generation if stylixFromImage=true)
    image = omarchyTheme.image;

    # If not using image-derived colors, use omarchy's base16 mapping
    base16Scheme = lib.mkIf (!cfg.stylixFromImage) omarchyTheme.base16Scheme;

    targets.chromium.enable = true;
  };
}
