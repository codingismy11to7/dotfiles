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
set -x PATH ~/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
    nvm use 22

    fastfetch
end
