{ lib, pkgs, ... }:
let
  inherit (lib) getExe;
in
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;

    # try to turn off all startup messages so our graphical
    # splash loads? not positive about all this, it seems to
    # work on some machines and not others.
    plymouth.enable = true;
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;

    # appimages
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = getExe pkgs.appimage-run;
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };
}
