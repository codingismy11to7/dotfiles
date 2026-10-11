{ config, ... }:
{
  dotfiles = {
    headless = true;
    omarchyTheme = "tokyo-night";
    wsl = true;
    nixdatifier = true;
    fastfetchLogo = ../terminus.png;
    personal.gitEmail = "steven@codemettle.com";
  };

  home-manager.users.${config.dotfiles.personal.username} =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.glab ];
    };
}
