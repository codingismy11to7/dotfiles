{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (lib) getExe mkDefault mkIf mkMerge;
  inherit (cfg)
    dotfilesPath
    headless
    keyboardLayout
    keyboardVariant
    ;
  browserPkg = pkgs.unstable.${cfg.browser};

  hostname = osConfig.networking.hostName;
  grep = getExe pkgs.gnugrep;
  gum = getExe pkgs.gum;
  sed = getExe pkgs.gnused;

  themeSetScript = pkgs.writeShellScriptBin "dotfiles-theme-set" ''
    THEME="$1"
    if [[ -z $THEME ]]; then
      echo "Usage: dotfiles-theme-set <theme-name>"
      exit 1
    fi

    CONFIG="${dotfilesPath}/hosts/${hostname}/config.nix"

    if ! [[ -f $CONFIG ]]; then
      echo "Host config not found: $CONFIG"
      exit 1
    fi

    choice=$(${gum} choose "Test (revert on reboot)" "Switch (permanent)" "Cancel")
    case "$choice" in
      Test*|Switch*) ;;
      *) echo "Cancelled"; exit 0 ;;
    esac

    if ${grep} -q 'omarchyTheme' "$CONFIG"; then
      ${sed} -i 's/omarchyTheme = "[^"]*"/omarchyTheme = "'"$THEME"'"/' "$CONFIG"
    else
      ${sed} -i '/dotfiles = {/a\    omarchyTheme = "'"$THEME"'";' "$CONFIG"
    fi

    echo "Theme set to $THEME in $CONFIG"
    echo

    case "$choice" in
      Test*) nh os test "${dotfilesPath}" ;;
      Switch*) nh os switch "${dotfilesPath}" ;;
    esac
  '';

  themeSetWrapper = pkgs.writeShellScriptBin "dotfiles-theme-set-menu" ''
    exec omarchy-launch-floating-terminal-with-presentation "${getExe themeSetScript} $1"
  '';
in
{
  imports = [
    inputs.omarchy.homeManagerModules.default
    ./personal-home.nix
  ];

  home.packages = [ themeSetScript themeSetWrapper ];

  omarchy = {
    git = {
      userName = mkDefault cfg.personal.fullName;
      userEmail = mkDefault cfg.personal.gitEmail;
    };

    hyprland.enable = !headless;
    terminal = if headless then null else mkDefault "ghostty";

    theme = mkDefault cfg.omarchyTheme;
    themeSetCommand = mkDefault "${getExe themeSetWrapper}";
    packages = mkMerge [
      { inherit (pkgs.unstable) fzf git; }
      (mkIf headless {
        imv = null;
        mpv = null;
        swayosd = null;
      })
    ];
    browser.webapp = mkIf (!headless) (mkDefault (config.omarchy.browser.wrapWithExtension browserPkg));
    keyboard = {
      layout = mkDefault keyboardLayout;
      variant = mkDefault keyboardVariant;
    };
    hyprland.package = mkDefault pkgs.unstable.hyprland;
  };
}
