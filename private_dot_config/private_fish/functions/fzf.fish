function fzf --wraps=fzf --description 'Use fzf-zellij if in zellij session'
    if _in_zellij
        ~/scripts/fzf-zellij $argv
    else 
        command fzf $argv
    end
end
