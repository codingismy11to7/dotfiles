{
  lib,
  osConfig,
  pkgs,
  ...
}:
with builtins;
let
  inherit (lib) concatStringsSep getExe;
  inherit (osConfig.dotfiles) fastfetchLogo;

  fastfetch = getExe pkgs.unstable.fastfetch;
  fastfetchCmd =
    if (fastfetchLogo == null) then
      fastfetch
    else
      "${fastfetch} --logo-height 23 --chafa ${fastfetchLogo}";

  tte = getExe pkgs.unstable.terminaltexteffects;
in
{
  home.packages = [
    pkgs.fish
    pkgs.nodejs_24 # remove if/when ai bots launch differently
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      fzf_configure_bindings --git_status= --git_log=

      bind ctrl-alt-l _lazygit_log
      bind ctrl-alt-s _lazygit_status

      ${fastfetchCmd}

      if not ${pkgs.openssh}/bin/ssh-add -l > /dev/null 2>&1
          echo "SSH identity not found. Please run 'ssh-add' to add your key." | ${tte} --frame-rate 300 wipe
      end
    '';

    functions = {
      _in_zellij = readFile ./functions/_in_zellij.fish;
      _lazygit_log = readFile ./functions/_lazygit_log.fish;
      _lazygit_status = readFile ./functions/_lazygit_status.fish;
      _run_cmd_in_zellij_popup = readFile ./functions/_run_cmd_in_zellij_popup.fish;
    };

    plugins = with pkgs.fishPlugins; [
      {
        name = "bass";
        inherit (bass) src;
      }
      {
        name = "fzf.fish";
        inherit (fzf-fish) src;
      }
      {
        name = "tide";
        inherit (tide) src;
      }
    ];
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home = {
    shellAliases = {
      cat = "${getExe pkgs.bat}";
      du = "${getExe pkgs.dust}";
      gembot = "${pkgs.nodejs_24}/bin/npx -y @google/gemini-cli@latest";
      lg = "${getExe pkgs.unstable.lazygit}";
      ls = "${getExe pkgs.eza}";
    };

    activation = {
      configureFishTide = lib.hm.dag.entryAfter [ "linkGeneration" ] (
        let
          tideArgs = concatStringsSep " " [
            "tide configure"
            "--auto"
            "--style=Rainbow"
            "--prompt_colors='True color'"
            "--show_time='12-hour format'"
            "--rainbow_prompt_separators=Angled"
            "--powerline_prompt_heads=Sharp"
            "--powerline_prompt_tails=Flat"
            "--powerline_prompt_style='Two lines, character and frame'"
            "--prompt_connection=Dotted"
            "--powerline_right_prompt_frame=No"
            "--prompt_connection_andor_frame_color=Dark"
            "--prompt_spacing=Sparse"
            "--icons='Many icons'"
            "--transient=Yes"
          ];
        in
        ''
          verboseEcho "Configuring Tide for Fish shell..."

          fish_function_path=${pkgs.fishPlugins.tide}/share/fish/vendor_functions.d/ \
            ${pkgs.fish}/bin/fish --interactive --command "${tideArgs}"
        ''
      );
    };
  };
}
