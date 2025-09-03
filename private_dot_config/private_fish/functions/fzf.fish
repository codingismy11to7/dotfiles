function fzf --wraps=fzf --description 'Use fzf-zellij if in zellij session'
    if set --query ZELLIJ
        ~/scripts/fzf-zellij $argv
    else 
        command fzf $argv
    end
end
