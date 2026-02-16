{
  config,
  lib,
  pkgs,
  ...
}:
with builtins;
let
  inherit (lib.options) mkOption mkEnableOption mkPackageOption;
  inherit (lib.types)
    attrsOf
    nullOr
    bool
    enum
    path
    str
    submodule
    ;

in
{
  options.dotfiles = mkOption {
    default = { };
    type = submodule {
      options = {
        hostname = mkOption {
          type = str;
        };

        headless = mkOption {
          type = bool;
          default = false;
          description = "Whether this is a headless system (no GUI)";
        };

        wsl = mkOption {
          type = bool;
          default = false;
          description = "Whether this is a WSL system";
        };

        virtManager = mkOption {
          type = bool;
          default = !config.dotfiles.headless;
          description = "Whether to enable virt-manager";
        };

        consoleKeyMap = mkOption {
          type = str;
          default = "dvorak";
        };

        keyboardLayout = mkOption {
          type = str;
          default = "us";
        };

        keyboardVariant = mkOption {
          type = str;
          default = "dvorak";
        };

        timeZone = mkOption {
          type = str;
          default = "America/New_York";
        };

        personal = mkOption {
          default = { };
          type = submodule {
            options = {
              username = mkOption {
                type = str;
                default = "steven";
              };

              fullName = mkOption {
                type = str;
                default = "Steven Scott";
              };

              gitEmail = mkOption {
                type = str;
              };
            };
          };
        };

        gaming = mkEnableOption "gaming packages";

        videoEncoding = mkEnableOption "video encoding tools (Handbrake, MakeMKV)";

        browser = mkOption {
          type = enum [
            "brave"
            "chromium"
            "google-chrome"
          ];
          default = "brave";
          description = "Which browser to use (will be wrapped with omarchy extensions)";
        };

        fastfetchLogo = mkOption {
          type = nullOr path;
          default = null;
        };

        syncthing.devices = mkOption {
          type = attrsOf str;
          default = {
            "jorge" = "EDF6L7D-2X5FJXS-N6MXOA5-COWXPGW-76NOVX2-KWSLEQL-S72S7MA-AYBQUAG";
            "nixorge" = "HOKYAKR-YOII4O7-FWR3QVL-5Z3J2LM-WODEPK3-HXOOFMA-CZVS3OC-6PJSQQX";
            "nixowsl" = "74I2NVA-JJX44MI-GNSKPAY-A4CXUSB-EV5C2RN-IN6T7DX-Q6VZM7E-A4E5JQZ";
            "nixxy386" = "PHURYRC-CZUYUEE-433AVVV-CKTHPOV-PTBMZ74-H5LAGYY-J6TBKKY-RIENDQZ";
            "Pixel 10 Pro XL" = "SLRZ6ZQ-R6YDDPJ-IKY5U42-2DAJHVG-ALB4UEA-UVB3XXT-6XCZGTB-PBLECQD";
            "surface" = "K5FTICV-5X5UAS3-TR6V2KP-2TBVZOE-K7LY7FQ-IN5UH4M-SJF3NEJ-4ABLQQL";
          };
          description = "Syncthing devices (name -> device ID) to share folders with";
        };

        omarchyTheme = mkOption {
          type = str;
          default = "ethereal";
          description = "Omarchy theme name (used for stylix integration)";
        };

        stylixFromImage = mkOption {
          type = bool;
          default = false;
          description = "If true, stylix generates colors from theme wallpaper. If false, uses omarchy's base16 color mapping.";
        };

        dotfilesPath = mkOption {
          type = path;
          default = "${config.users.defaultUserHome}/${config.dotfiles.personal.username}/dotfiles";
          description = "Absolute path to the dotfiles repo on this machine";
        };

      };
    };
  };
}
