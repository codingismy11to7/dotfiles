set -x fzf_directory_opts --bind "ctrl-v:execute(vim {} &> /dev/tty)"
set -x fzf_preview_file_cmd ~/scripts/fzf-preview
set -x FZF_DEFAULT_OPTS '
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#00afff
  --color=prompt:#5f5faf,spinner:#ff0000,pointer:#ff0000,header:#87afaf
  --color=border:#afff00,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="❯ "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"
  --layout="reverse" --info="right"'


set -x EDITOR vim
set -x PATH ~/bin ~/.local/share/omarchy/bin ~/.nix-profile/bin $PATH

bind ctrl-l "source "(realpath (status -f)) repaint
bind ctrl-alt-l _lazygit_log
bind ctrl-alt-s _lazygit_status

# ok so gemini and i came up with this, it's valid at this moment, who
# knows if it will break in the future. try to grab all the exports
# from the nixGL script and load them into our environment. today this
# script is just a shebang, an empty line, exports, and then an exec 
# $argv line. so just extracting the variables is ok, today.
if command -q nixGL
    set nixGL_path (which nixGL)
    if test -n "$nixGL_path"
        cat $nixGL_path | grep '^\s*export ' | bass source /dev/stdin
    end
end

if status is-interactive
    # if it's already installed this acts as `nvm use`
    nvm install $NODE_VERSION

    fastfetch
end
