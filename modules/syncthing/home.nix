{
  osConfig,
  lib,
  ...
}:
with builtins;
let

  inherit (osConfig.dotfiles) headless;
  inherit (lib) mapAttrs;

  cfg = osConfig.dotfiles.syncthing;
  devices = mapAttrs (name: id: { inherit id; }) cfg.devices;
in
{
  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      inherit devices;
      folders = {
        "Sync" = {
          path = "~/Sync";
          devices = attrNames cfg.devices;
          ignorePerms = false;
        };
      };
    };
    tray.enable = !headless;
  };
}
