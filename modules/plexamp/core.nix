{ ... }:
{
  # Plexamp expects UPower for power management queries
  services.upower.enable = true;

  nixpkgs.overlays = [
    (_final: prev: {
      plexamp = prev.symlinkJoin {
        name = "plexamp-wrapped";
        paths = [ prev.plexamp ];
        nativeBuildInputs = [ prev.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/plexamp \
            --add-flags "--enable-features=MediaSessionService,HardwareMediaKeyHandling"
        '';
      };
    })
  ];
}
