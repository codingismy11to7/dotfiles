{ config, pkgs, ... }: {
  environment.systemPackages = [ pkgs.unstable.pritunl-client ];

  systemd.packages = [ pkgs.unstable.pritunl-client ];
  systemd.services.pritunl-client.wantedBy = [ "multi-user.target" ];

  home-manager.users.${config.dotfiles.personal.username}.omarchy = {
    hyprland.monitorConfig = ''
      env = GDK_SCALE,1.25
      monitor=,preferred,auto,1.6
    '';
    hyprland.bindings = [
      "bindl = , switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
      "bindl = , switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, preferred, auto, 1.6\""
    ];
  };

  dotfiles = {
    omarchyTheme = "tokyo-night";
    fastfetchLogo = ./terminus.png;
    personal.gitEmail = "steven@codemettle.com";
  };
}
