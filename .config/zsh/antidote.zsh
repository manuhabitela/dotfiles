# fast way to load antidote
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins
# Lazy-load antidote from its functions directory.
fpath=(/usr/share/zsh-antidote/functions $fpath)
autoload -Uz antidote
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi
source ${zsh_plugins}.zsh