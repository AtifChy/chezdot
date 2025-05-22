# wsl2 ssh integration
if [[ -n $WSLENV ]] && (( ${+commands[wsl2-ssh-agent]} )); then
  agent_socket=$HOME/.ssh/wsl2-ssh-agent.sock
  if [[ -S $agent_socket ]]; then
    export SSH_AUTH_SOCK=$agent_socket
  else
    source <(wsl2-ssh-agent -format zsh)
  fi
fi

