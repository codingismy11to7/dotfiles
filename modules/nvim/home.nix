{
  config,
  inputs,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
in
{
  home.sessionVariables.EDITOR = "nvim";

  home.packages = [
    (inputs.nvim.lib.mkNeovim {
      pkgs = pkgs.unstable;
      inherit (pkgs.stdenv.hostPlatform) system;
      theme = {
        content =
          if cfg.headless then
            inputs.omarchy.lazyvimTheme.forTheme cfg.omarchyTheme
          else
            inputs.omarchy.lazyvimTheme.default { inherit config; };
      };
    })
  ];
}
