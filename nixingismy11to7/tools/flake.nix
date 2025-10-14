{
  description = "stuff i want available on every machine i use";

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
          the-needfuls = with pkgs; [
            bat
            btop
            chafa
            curl
            delta
            fastfetch
            fd
            fzf
            git
            lazygit
            nixfmt
            sourcegit
            unzip
            vim
            wget
            zellij
            zip
          ];
        in
        {
          # This creates a single "package" that contains all our tools
          default = pkgs.buildEnv {
            name = "tools";
            paths = the-needfuls;
          };
        }
      );
    };
}
