export GPG_TTY=$TTY

if [[ -n $WSLENV ]]; then
  export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/wsl2-ssh-agent.sock
  return
fi

unset SSH_AGENT_PID
if [[ ${gnupg_SSH_AUTH_SOCK_by:-0} -ne $$ ]]; then
  export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh
fi

function _gpg_agent_update_tty_preexec {
  gpg-connect-agent updatestartuptty /bye &>/dev/null
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _gpg_agent_update_tty_preexec
