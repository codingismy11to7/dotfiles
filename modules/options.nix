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
}
