HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
alias hist='fc -li'
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
