#taken kolo theme as a base

autoload -U colors && colors

autoload -Uz vcs_info

darkgrey=$FG[244]
lightgrey=$FG[248]

zstyle ':vcs_info:*' stagedstr '%F{green}%B^'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}%B^'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b:%F{2}%r'
zstyle ':vcs_info:*' enable git svn
theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%b%c%u%F{green} '
    } else {
        zstyle ':vcs_info:*' formats '%b%c%u%F{red}%B^%F{green} '
    }

    vcs_info
}

setopt prompt_subst
PROMPT='%F{green}${vcs_info_msg_0_}%F{yellow}%1~%{$reset_color%} '
RPROMPT='%{$darkgrey%}%*%{$reset_color%}'

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
