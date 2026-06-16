{ inputs, ... }:
{
  nixpkgs.overlays = [
    (_final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (prev.stdenv.hostPlatform) system;
        config = {
          allowUnfree = true;
          # bitwarden-desktop 2026.5.0 (same in 26.05 and unstable) pins electron 39,
          # which hit EOL ~2026-06 and is now flagged insecure. Allowed until bitwarden
          # upstream moves to a supported electron; remove this entry then.
          permittedInsecurePackages = [ "electron-39.8.10" ];
        };
      };
    })
  ];
}
