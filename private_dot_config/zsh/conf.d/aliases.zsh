#
# normal aliases
#

if (( ${+commands[eza]} )); then
  alias ls='eza --icons=auto --git --color=auto --group-directories-first'
else
  alias ls='ls --color=auto --group-directories-first'
fi
alias la='ls -a'
alias l='ls -lh'
alias ll='ls -alh'
alias lr='ls -aR'
alias lR='ls -alRh'

alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -Iv'
alias ln='ln -iv'
alias rd='rmdir -v'
alias mkdir='mkdir -pv'

alias chown='chown -v --preserve-root'
alias chmod='chmod -v --preserve-root'
alias chgrp='chgrp -v --preserve-root'

alias grep='grep --color=auto'
alias egrep='grep -E'
alias fgrep='grep -F'

alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias ping='ping -c 5 -W 30'
alias watch='watch --color'
alias df='df -h'
alias du='du -ch'
alias dmesg='dmesg -H'
alias free='free -h'
alias cat='bat --style=plain --paging=never'

alias reload='exec zsh'
alias :q='exit'
alias :x='exit'

# aliases for dotfiles bare repo
# alias dot="git --git-dir=${XDG_DATA_HOME}/dotfiles --work-tree=${HOME}"
# alias lazydot="lazygit --git-dir=${XDG_DATA_HOME}/dotfiles --work-tree=${HOME}"

if (( UID )); then
  alias root='sudo --preserve-env --shell'
  alias scat='sudo cat'
fi

#
# abbreviations
#

(( ${+functions[abbr]} )) || return

abbr ..='cd ..'
abbr ...='cd ../..'
abbr ....='cd ../../..'
abbr .....='cd ../../../..'

abbr ff=fastfetch
abbr v=nvim
abbr cz=chezmoi

(( UID )) && abbr sv=sudoedit
