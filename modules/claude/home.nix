{ config, osConfig, ... }:
let
  cfg = osConfig.dotfiles;
in
{
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${cfg.dotfilesPath}/modules/claude/CLAUDE.md";
}
