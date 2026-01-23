{
  config,
  lib,
  pkgs,
  self,
  ...
}:
with builtins;
let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkOption mkEnableOption mkPackageOption;
  inherit (lib.meta) getExe;
  inherit (lib.types)
    nullOr
    bool
    enum
    float
    int
    lines
    oneOf
    path
    str
    submodule
    ;
  inherit (lib)
    concatMapAttrs
    hasPrefix
    importTOML
    literalExpression
    mapAttrs'
    mapAttrsToList
    mkDefault
    nameValuePair
    optional
    removePrefix
    stringToCharacters
    toUpper
    types
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

        fastfetchLogo = mkOption {
          type = nullOr path;
          default = null;
        };

        monitorConfig = mkOption {
          type = lines;
          default = "";
          description = "Hyprland monitor configuration";
        };
      };
    };
  };
}
