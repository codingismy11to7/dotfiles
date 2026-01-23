{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    package = pkgs.unstable.lazygit;
    settings = {
      disableStartupPopups = true;
      notARepository = "skip";
      update.method = "never";
      git = {
        parseEmoji = true;
        ignoreWhitespaceInDiffView = true;
        log.showGraph = "when-maximised";
        pagers = [
          {
            colorArg = "always";
            page = "${pkgs.unstable.delta}/bin/delta --dark --paging=never";
          }
        ];
      };
      gui = {
        showRandomTip = false;
        nerdFontsVersion = "3";
        spinner = {
          rate = 250;
          frames = [
            "🕛 "
            "🕐 "
            "🕑 "
            "🕒 "
            "🕓 "
            "🕔 "
            "🕕 "
            "🕖 "
            "🕗 "
            "🕘 "
            "🕙 "
            "🕚 "
          ];
        };
      };
    };
  };
}
