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