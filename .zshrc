PATH="/bin"
PATH="$PATH:/sbin"
PATH="$PATH:/usr/bin"
PATH="$PATH:/usr/game"
PATH="$PATH:/usr/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/lib/lightdm/lightdm"
export PATH="$PATH:$HOME/bin"

source_sh () {
  emulate -LR sh
  . "$@"
}

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Themes: ~/.oh-my-zsh/themes/
# ZSH_THEME="robbyrussell"
ZSH_THEME="leimi"

COMPLETION_WAITING_DOTS="true"

# Plugins: ~/.oh-my-zsh/plugins/
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian nyan svn)

source $ZSH/oh-my-zsh.sh

setopt auto_cd
cdpath=($HOME/Dev $HOME/Dev/httpd $HOME/Dev/vagrant $HOME/Dropbox/Web/localhost)

source_sh $HOME/.aliases