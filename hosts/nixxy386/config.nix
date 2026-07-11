{ config, ... }:
{
  dotfiles.wireshark = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraSetFlags = [
      "--exit-node=auto:any"
      "--exit-node-allow-lan-access"
      "--accept-routes"
      "--report-posture"
    ];
  };

  home-manager.users.${config.dotfiles.personal.username} =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.glab
        pkgs.unstable.jetbrains-toolbox
        pkgs.unstable.snyk
        (pkgs.writeShellScriptBin "tailscale-up" ''
          sudo tailscale up --exit-node=auto:any --exit-node-allow-lan-access --report-posture --accept-routes
        '')
      ];

      services.tailscale-systray.enable = true;

      omarchy = {
        media.sensitiveVolume = true;
        screensaver.text = builtins.readFile ./cm.txt;
        hyprland.monitorConfig = ''
          hl.env("GDK_SCALE", "1.25")
          hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.6 })
        '';
        # Lid-switch handling is now upstream (omarchy default/hypr/bindings/utilities.lua
        # binds Lid Switch to omarchy-hyprland-monitor-internal), so the custom
        # bindl entries were dropped in the hyprland-lua migration.
        webapps.figma.enable = true;
      };
    };

  dotfiles = {
    kernel = "zen";
    omarchyTheme = "tokyo-night";
    fastfetchLogo = ../terminus.png;
    personal.gitEmail = "steven@codemettle.com";
  };
}
