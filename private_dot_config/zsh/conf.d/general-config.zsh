# general settings
setopt auto_cd                              # change to directory without cd
setopt interactive_comments                 # allow comments in interactive shell
setopt no_beep                              # disable beeping on tab completion
setopt auto_menu                            # show completion menu on successive tabs
setopt complete_in_word                     # allow completion from both ends
setopt always_to_end                        # move cursor to end of completion
setopt no_flow_control                      # disable shell pause/resume with ^S/^Q
setopt nomatch                              # print error message on failed globbing
setopt rc_quotes                            # escape single quotes in single quotes
setopt correct                              # autocorrect commands
setopt no_auto_param_slash                  # disable automatic slash insertion
setopt glob_dots                            # include dotfiles in completion
setopt extended_glob                        # enable extended globbing

# history settings
setopt extended_history                     # save timestamp and duration of command
setopt hist_ignore_dups                     # ignore duplicate commands
setopt hist_ignore_all_dups                 # ignore all duplicate commands
setopt hist_ignore_space                    # ignore commands starting with space
setopt hist_reduce_blanks                   # remove leading and trailing blanks
setopt hist_expire_dups_first               # remove duplicates first when history is full
setopt hist_verify                          # verify history expansion
setopt share_history                        # share history between sessions
setopt inc_append_history                   # append new history to history file

# completion config
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' insert-tab false
# zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' verbose true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*' list-separator '->'
zstyle ':completion:*:default' list-colors '=(#b)*(-> *)==33;3' ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*:default' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:corrections' format '%B%%F{yellow}!-> %d (error: %e) <-!%f%b'
zstyle ':completion:*:descriptions' format '%B%F{cyan}--> %d <--%f%b'
zstyle ':completion:*:warnings' format '%B%F{red}--> no match found <--%f%b'
zstyle ':completion:*:messages' format '%B%F{yellow}--> %d <--%f%B'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:(vim|nvim|vi|nano):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|png|jpeg|jpg|gif|zwc)'
zstyle ':completion:*:matches' group yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# on-demand rehash using SIGUSR1
# NOTE requires pacman hook to be installed
# https://wiki.archlinux.org/title/Zsh#Alternative_on-demand_rehash_using_SIGUSR1
trap 'rehash' USR1

# auto quote problematic urls
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# disable highlight of pasted text
zle_highlight+=(paste:none)

# prompt used in multiline commands
PROMPT2="%8F·%f "

# change zsh eol character
[[ $TERM == 'linux' ]] || PROMPT_EOL_MARK='%F{8}󰘌%f'

# autocorrect prompt
SPROMPT='zsh: correct %B%F{red}%R%f%b to %B%F{green}%r%f%b [nyae]? '

# a list of non-alphanum chars considered part of a word by the line editor.
# zsh's default is "*?_-.[]~=/&;!#$%^(){}<>"
# WORDCHARS='@_-'

# generate completion from `--help`
compdef _gnu_generic fzf dircolors trash
