{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.pritunl-client ];

  systemd.packages = [ pkgs.unstable.pritunl-client ];
  systemd.services.pritunl-client.wantedBy = [ "multi-user.target" ];

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

  home-manager.users.${config.dotfiles.personal.username} = { pkgs, ... }: {
    home.packages = [
      pkgs.unstable.jetbrains-toolbox
      pkgs.unstable.snyk
      (pkgs.writeShellScriptBin "tailscale-up" ''
        sudo tailscale up --exit-node=auto:any --exit-node-allow-lan-access --report-posture --accept-routes
      '')
    ];

    services.tailscale-systray.enable = true;
    omarchy = {
      screensaver.text = builtins.readFile ./cm.txt;
      hyprland.monitorConfig = ''
        env = GDK_SCALE,1.25
        monitor=,preferred,auto,1.6
      '';
      hyprland.bindings = [
        "bindl = , switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
        "bindl = , switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, preferred, auto, 1.6\""
      ];
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
