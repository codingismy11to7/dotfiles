{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib) getExe' mkIf;
  cfg = osConfig.dotfiles.nextcloud;
  inherit (osConfig.dotfiles) headless;
  homeDir = config.home.homeDirectory;
  syncDir = "${homeDir}/${cfg.subdirectory}";
  nextcloudcmd = getExe' cfg.package "nextcloudcmd";
  configDir = "${config.xdg.configHome}/Nextcloud";
  configFile = "${configDir}/nextcloud.cfg";

  defaultConfig = ''
    [Accounts]
    0\Folders\1\ignoreHiddenFiles=false
    0\Folders\1\localPath=${syncDir}/
    0\Folders\1\paused=false
    0\Folders\1\targetPath=/
    0\Folders\1\virtualFilesMode=off
    0\authType=webflow
    0\dav_user=${cfg.username}
    0\displayName=${cfg.username}
    0\url=${cfg.url}
    0\webflow_user=${cfg.username}
    version=2
  '';

  syncScript = pkgs.writeShellScript "nextcloud-sync" ''
    export NC_PASSWORD="$(cat "${config.sops.secrets.nextcloudPassword.path}")"
    ${nextcloudcmd} \
      --non-interactive \
      --user ${cfg.username} \
      -h \
      ${syncDir} \
      ${cfg.url}
  '';
in
mkIf cfg.enable {
  home = {
    activation = {
      createNextcloudDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p "${syncDir}"
      '';
      prefillNextcloudConfig = mkIf (!headless) (lib.hm.dag.entryBefore [ "writeBoundary" ] ''
        if [ ! -f "${configFile}" ]; then
          run mkdir -p "${configDir}"
          run cat > "${configFile}" << 'EOF'
        ${defaultConfig}
        EOF
        fi
      '');
    };
    packages = mkIf (!headless) [ cfg.package ];
  };

  services.nextcloud-client = mkIf (!headless) {
    enable = true;
    startInBackground = true;
    inherit (cfg) package;
  };

  systemd.user = {
    services.nextcloud-autosync = {
      Unit = {
        Description = "Auto sync Nextcloud";
        After = "network-online.target";
      };
      Service = {
        Type = "simple";
        ExecStart = toString syncScript;
        TimeoutStopSec = "180";
        KillMode = "process";
        KillSignal = "SIGINT";
      };
      Install.WantedBy = [ "default.target" ];
    };
    timers.nextcloud-autosync = {
      Unit.Description = "Automatically sync files with Nextcloud";
      Timer = {
        OnBootSec = cfg.onBootTime;
        OnUnitActiveSec = cfg.onUnitActiveTime;
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
