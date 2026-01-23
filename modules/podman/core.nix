{ pkgs, ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages =
    (with pkgs.unstable; [
      distrobox
      distrobox-tui
      lazydocker
    ])
    ++ (with pkgs; [
      podman-compose
    ]);
}
