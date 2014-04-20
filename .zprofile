PATH="/bin"
PATH="$PATH:/sbin"
PATH="$PATH:/usr/bin"
PATH="$PATH:/usr/game"
PATH="$PATH:/usr/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/lib/lightdm/lightdm"
PATH="$PATH:$HOME/.rvm/bin"
PATH="$PATH:$HOME/.rvm/rubies/ruby-1.9.3-p362/bin"
PATH="$PATH:$HOME/.rvm/gems/ruby-1.9.3-p362@global/bin"
PATH="$PATH:$HOME/.rvm/gems/ruby-1.9.3-p362/bin"
export PATH="$PATH:$HOME/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source_sh () {
  emulate -LR sh
  . "$@"
}

CHROME_DEVEL_SANDBOX="$HOME/opt/chrome-linux/chrome_sandbox"