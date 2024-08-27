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
# setopt no_auto_param_slash                  # disable automatic slash insertion
setopt glob_dots                            # include dotfiles in completion
setopt extended_glob                        # enable extended globbing

# history settings
setopt extended_history                     # save timestamp and duration of command
setopt hist_ignore_dups                     # ignore duplicate commands
# setopt hist_ignore_all_dups                 # ignore all duplicate commands
setopt hist_ignore_space                    # ignore commands starting with space
setopt hist_reduce_blanks                   # remove leading and trailing blanks
setopt hist_expire_dups_first               # remove duplicates first when history is full
setopt hist_verify                          # verify history expansion
setopt share_history                        # share history between sessions
setopt inc_append_history                   # append new history to history file

# auto quote problematic urls
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# disable highlight of pasted text
zle_highlight+=(paste:none)

# prompt used in multiline commands
PROMPT2="%8F·%f "

# change zsh eol character
[[ $TERM == (dumb|linux) ]] || PROMPT_EOL_MARK='%F{8}󰘌%f'

# autocorrect prompt
SPROMPT='zsh: correct %B%F{red}%R%f%b to %B%F{green}%r%f%b [nyae]? '

# generate completion from `--help`
compdef _gnu_generic \
  fzf \
  dircolors \
  trash

# use eza completion for exa
compdef exa=eza
