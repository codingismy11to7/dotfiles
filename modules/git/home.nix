{ osConfig, pkgs, ... }:
let
  cfg = osConfig.dotfiles;
  inherit (cfg.personal) fullName gitEmail;
in
{
  programs.git = {
    enable = true;
    package = pkgs.unstable.git;

    settings = {
      user = {
        name = fullName;
        email = gitEmail;
      };

      pull.rebase = true;
      push.default = "simple";
    };
  };
}
