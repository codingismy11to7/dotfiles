{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dotfiles;
  inherit (pkgs.stdenv.hostPlatform) isx86;
  hasOpticalDrive = config.hardware.facter.report.hardware.cdrom or [ ] != [ ];
in
{
  config = lib.mkIf (cfg.videoEncoding && hasOpticalDrive) {
    users.users.${cfg.personal.username}.extraGroups = [ "cdrom" ];
    # SCSI generic driver for MakeMKV
    boot.kernelModules = [ "sg" ];

    services.flatpak.packages = lib.optionals isx86 [
      "com.makemkv.MakeMKV"
    ];
  };
}
