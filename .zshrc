# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Themes: ~/.oh-my-zsh/themes/
ZSH_THEME="leimi"

COMPLETION_WAITING_DOTS="true"

# Plugins: ~/.oh-my-zsh/plugins/
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ssh-agent colored-man-pages)

zstyle :omz:plugins:ssh-agent agent-forwarding on

zstyle ':completion::complete:make:*:targets' call-command true

source $ZSH/oh-my-zsh.sh

setopt auto_cd
cdpath=($HOME $HOME/dev)
HISTSIZE=10000000
SAVEHIST=10000000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

TMOUT=1
TRAPALRM() {
  zle reset-prompt
}

function omz_termsupport_precmd {
  [[ "$DISABLE_AUTO_TITLE" == true ]] && return
  # dont show our local user@host in title
  title "%15<..<%~%<<" "%15<..<%~%<<"
}

source $HOME/.zshaliases
EDITOR=nano
export REACT_EDITOR=subl
