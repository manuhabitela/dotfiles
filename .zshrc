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
if [[ -a $HOME/.gem/ruby/2.3.0/bin ]]; then
	PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
fi
if [[ -a $HOME/.gem/ruby/2.4.0/bin ]]; then
	PATH="$PATH:$HOME/.gem/ruby/2.4.0/bin"
fi
if [[ -a $HOME/android/sdk ]]; then
	export ANDROID_HOME="$HOME/android/sdk"
	PATH="$PATH:$ANDROID_HOME/tools"
	PATH="$PATH:$ANDROID_HOME/platform-tools"
fi
if [[ -a $HOME/.cargo/bin ]]; then
	PATH="$HOME/.cargo/bin:$PATH"
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
plugins=(git ssh-agent colored-man-pages)

zstyle :omz:plugins:ssh-agent agent-forwarding on

source $ZSH/oh-my-zsh.sh

setopt auto_cd
cdpath=($HOME/vt $HOME/dev $HOME/Dev $HOME/Dropbox/Web/localhost)

source $HOME/.zsh_aliases
POCKER_HOME=/home/manu/vt
export REACT_EDITOR=subl
