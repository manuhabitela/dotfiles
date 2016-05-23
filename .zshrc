PATH="$PATH:$HOME/.rvm/bin"
PATH="$PATH/bin"
PATH="$PATH:/sbin"
PATH="$PATH:/usr/bin"
PATH="$PATH:/usr/game"
PATH="$PATH:/usr/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/lib/lightdm/lightdm"
PATH="$PATH:/usr/bin/core_perl/"
PATH="$PATH:/usr/local/go/bin"
PATH="$PATH:$HOME/.composer/vendor/bin"
if [[ -a $HOME/Dev/ecolutis/dkr/bin ]]; then
    PATH="$PATH:$HOME/Dev/ecolutis/dkr/bin"
fi
if [[ -a $HOME/Dev/ecolutis/www/cmd/bin ]]; then
    PATH="$PATH:$HOME/Dev/ecolutis/www/cmd/bin"
fi
export PATH="$PATH:$HOME/bin"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Themes: ~/.oh-my-zsh/themes/
ZSH_THEME="leimi"

COMPLETION_WAITING_DOTS="true"

# Plugins: ~/.oh-my-zsh/plugins/
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git nyan ssh-agent colored-man-pages)

zstyle :omz:plugins:ssh-agent agent-forwarding on

source $ZSH/oh-my-zsh.sh

setopt auto_cd
cdpath=($HOME/Dev $HOME/Dev/ecolutis $HOME/Dev/ecolutis/www/ecolutis.dev $HOME/Dropbox/Web/localhost)

source $HOME/.zsh_aliases

if [[ -a $HOME/Dev/ecolutis/dkr ]]; then
    export EDKR_HOME="$HOME/Dev/ecolutis/dkr"
fi
