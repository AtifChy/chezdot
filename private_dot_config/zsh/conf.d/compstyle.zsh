# smart case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# fuzzy match completion
zstyle ':completion:*' completer _complete _match _correct _ignored _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# list style
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' verbose true
zstyle ':completion:*' list-separator '->'
zstyle ':completion:*:default' list-colors '=(#b)*(-> *)==33;3' ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*:default' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:corrections' format '%B%%F{yellow}!-> %d (error: %e) <-!%f%b'
zstyle ':completion:*:descriptions' format '%B%F{cyan}--> %d <--%f%b'
zstyle ':completion:*:warnings' format '%B%F{red}--> no match found <--%f%b'
zstyle ':completion:*:messages' format '%B%F{yellow}--> %d <--%f%B'

# misc
zstyle ':completion:*' insert-tab false
# zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:(vim|nvim|vi|nano):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|png|jpeg|jpg|gif|zwc)(|.old)'
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true

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
