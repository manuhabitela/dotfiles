source $HOME/opt/gitstatus/gitstatus.plugin.zsh
darkgrey=$FG[244]

theme_precmd () {

  # dont show our local user@host in title
  # if [[ "$DISABLE_AUTO_TITLE" != true ]]; then
  #   title "%15<..<%~%<<" "%15<..<%~%<<"
  # fi

  # git logic taken from gitstatus.prompt.zsh
  local current_dir="%F{yellow}%1~%{$reset_color%} "
  local p

  if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
    local where  # branch name, tag or commit
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      where=$VCS_STATUS_LOCAL_BRANCH
    elif [[ -n $VCS_STATUS_TAG ]]; then
      p+='%f#'
      where=$VCS_STATUS_TAG
    else
      p+='%f@'
      where=${VCS_STATUS_COMMIT[1,8]}
    fi

    (( $#where > 32 )) && where[13,-13]="…"  # truncate long branch names and tags
    p+="%F{green}${where//\%/%%}%{$reset_color%}" # escape %

    [[ -n $VCS_STATUS_ACTION     ]] && p+="%F{red}%B${VCS_STATUS_ACTION}%b"
    (( VCS_STATUS_NUM_STAGED     )) && p+="%F{green}%B^%b"
    (( VCS_STATUS_NUM_UNSTAGED   )) && p+="%F{yellow}%B^%b"
    (( VCS_STATUS_NUM_UNTRACKE   )) && p+="%F{red}%B^%b"
    PROMPT="${p} ${current_dir}"
  else
    PROMPT="${current_dir}"
  fi
  RPROMPT="%{$darkgrey%}%*%{$reset_color%}"

  setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
add-zsh-hook precmd theme_precmd
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
