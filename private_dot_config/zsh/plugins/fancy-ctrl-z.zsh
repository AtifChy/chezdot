function fancy-ctrl-z {
  if (( ! $#BUFFER )); then
    BUFFER="fg"
    zle accept-line -w
  else
    zle undo -w
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
