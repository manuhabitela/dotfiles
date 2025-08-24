setopt complete_in_word     # Complete from both ends of a word.
setopt always_to_end        # Move cursor to the end of a completed word.
setopt auto_menu            # Show completion menu on a successive tab press.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt extended_glob        # Needed for file modification glob modifiers with compinit.
setopt auto_param_slash     # If completed parameter is a directory, add a trailing slash.
setopt NO_menu_complete     # Do not autoselect the first completion entry.
setopt NO_flow_control      # Disable start/stop characters in shell editor.



function run-compinit {
  emulate -L zsh
  setopt localoptions extendedglob

  local force=0
  if [[ "$1" == "-f" ]]; then
    force=1
    shift
  fi

  local zcompdump=${1:-${ZSH_COMPDUMP:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump}}
  [[ -d "$zcompdump:h" ]] || mkdir -p "$zcompdump:h"
  autoload -Uz compinit

  # if compdump is less than 20 hours old,
  # consider it fresh and shortcut it with `compinit -C`
  #
  # Glob magic explained:
  #   #q expands globs in conditional expressions
  #   N - sets null_glob option (no error on 0 results)
  #   mh-20 - modified less than 20 hours ago
  if [[ $force -ne 1 ]] && [[ $zcompdump(#qNmh-20) ]]; then
    # -C (skip function check) implies -i (skip security check).
    compinit -C -d "$zcompdump"
  else
    compinit -i -d "$zcompdump"
    touch "$zcompdump"
  fi

  # Compile zcompdump, if modified, in background to increase startup speed.
  {
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
      if command mkdir "${zcompdump}.zwc.lock" 2>/dev/null; then
        zcompile "$zcompdump"
        command rmdir  "${zcompdump}.zwc.lock" 2>/dev/null
      fi
    fi
  } &!
}

# Let's talk compinit... compinit works by finding _completion files in your fpath. That
# means fpath has to be fully populated prior to calling compinit. If you use oh-my-zsh,
# if populates fpath and runs compinit prior to loading plugins. This is only
# problematic if you expect to be able to add to fpath later. Conversely, if you wait to
# run compinit until the end of your config, then functions like compdef aren't
# available earlier in your config.
#
# TLDR; this code handles all those use cases and simply queues calls to compdef and
# hooks compinit to precmd for one call only, which happens automatically at the end of
# your config. You can override this behavior with zstyles.
if zstyle -t ':zephyr:plugin:completion' immediate; then
  run-compinit
else
  # Define compinit placeholder functions (compdef) so we can queue up calls to compdef.
  # That way when the real compinit is called, we can execute the queue.
  typeset -gHa __zephyr_compdef_queue=()
  function compdef {
    (( $# )) || return
    local compdef_args=("${@[@]}")
    __zephyr_compdef_queue+=("$(typeset -p compdef_args)")
  }

  # Wrap compinit temporarily so that when the real compinit call happens, the
  # queue of compdef calls is processed.
  function compinit {
    unfunction compinit compdef &>/dev/null
    autoload -Uz compinit && compinit "$@"
    local typedef_compdef_args
    for typedef_compdef_args in $__zephyr_compdef_queue; do
      eval $typedef_compdef_args
      compdef "$compdef_args[@]"
    done
    unset __zephyr_compdef_queue
  }

  # If the user didn't specify they wanted to manually initialize completions,
  # then attach compinit to the precmd hook so that it happens at the very end.
  if ! zstyle -t ':zephyr:plugin:completion' manual; then
    autoload -Uz add-zsh-hook
    function run-compinit-precmd {
      run-compinit
      add-zsh-hook -d precmd run-compinit-precmd
    }
    add-zsh-hook precmd run-compinit-precmd
  fi
fi
