{ config, ... }:
let
  cfg = config.dotfiles;
in
{
  time.timeZone = cfg.timeZone;

  console.keyMap = cfg.consoleKeyMap;

  services.xserver.xkb = {
    layout = cfg.keyboardLayout;
    variant = cfg.keyboardVariant;
  };
}
