{
  description = "copied and modified from henrysipp/omarchy-nix";

  inputs = {
    # The primary source for packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      # List of systems you want to support
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      # Helper function to generate the shell for each system
      forAllSystems = nixpkgs.lib.genAttrs systems;

    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          # Essential Hyprland packages - cannot be excluded
          hyprlandPackages = with pkgs; [
            hyprshot
            hyprpicker
            hyprsunset
            brightnessctl
            pamixer
            playerctl
            gnome-themes-extra
            pavucontrol
          ];

          # Essential system packages - cannot be excluded
          systemPackages = with pkgs; [
            git
            vim
            libnotify
            nautilus
            alejandra
            blueberry
            clipse
            fzf
            zoxide
            ripgrep
            eza
            fd
            # curl
            unzip
            wget
            gnumake
          ];
        in
        {
          # This creates a single "package" that contains all our tools
          default = pkgs.buildEnv {
            name = "omarchyDeps";
            paths = hyprlandPackages ++ systemPackages;
          };
        }
      );
    };
}
