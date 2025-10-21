{
  description = "copied and modified from henrysipp/omarchy-nix";

  inputs = {
    # The primary source for packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # bug happening literally right now
    # elephlake.url = "github:abenz1267/elephant";
    elephlake.url = "github:Ori-Riaru/elephant/windows-provider";
  };

  outputs =
    {
      self,
      nixpkgs,
      elephlake,
      ...
    }:
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

          polkit_gnome = pkgs.polkit_gnome;
          polkit-gnome-agent = pkgs.writeShellScriptBin "polkit-gnome-agent" ''
            exec ${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
          '';

          # Essential Hyprland packages - cannot be excluded
          hyprlandPackages = with pkgs; [
            hypridle
            hyprland-qtutils
            hyprland
            hyprlock
            hyprshot
            hyprpicker
            hyprsunset
            brightnessctl
            evince
            gnome-themes-extra
            gpu-screen-recorder
            mako
            pamixer
            playerctl
            polkit-gnome-agent
            swaybg
            swayosd
            uwsm
            walker
            waybar
            wl-clip-persist
            wl-clipboard
          ];

          # Essential system packages - cannot be excluded
          systemPackages = with pkgs; [
            chromium
            dust
            imv
            mpv
            power-profiles-daemon
            vim
            curl
            eza
            fd
            fzf
            git
            gum
            imagemagick
            libnotify
            libxkbcommon
            nautilus
            alacritty
            alejandra
            blueberry
            clipse
            elephlake.packages.${system}.default
            ripgrep
            terminaltexteffects
            tzupdate
            unzip
            wget
            zoxide
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
