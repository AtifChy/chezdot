# based on ohmyzsh/lib/termsupport.zsh

ZSH_WINDOW_TITLE="%n@%m:%30<…<%~%<<"
ZSH_TAB_TITLE="%30<…<%~%<<"

function title {
  # Don't set the title if inside emacs, unless using vterm
  [[ -n "${INSIDE_EMACS:-}" && "$INSIDE_EMACS" != vterm ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*|wezterm*)
      printf '\e]1;%s\a' ${(%)1}      # set tab title
      printf '\e]2;%s\a' ${(%)2}      # set window title
      ;;
    screen*|tmux*)
      printf '\ek%s\e\\' ${(%)1}
      ;;
  esac
}

function __title_precmd {
  title "$ZSH_TAB_TITLE" "$ZSH_WINDOW_TITLE"
}

function __title_preexec {
  emulate -L zsh -o extended_glob

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD="${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}"
  local LINE="${2:gs/%/%%}"

  title "$CMD" "%50>...>${LINE}%<<"
}

# emits the control sequence to notify the terminal of cwd
function __title_cwd {
  print -Pn "\e]7;file://%m%d\e\\"
}

# add hooks to update the title
autoload -Uz add-zsh-hook

if [[ -z "$INSIDE_EMACS" || "$INSIDE_EMACS" = vterm ]]; then
  add-zsh-hook -Uz precmd __title_precmd
  add-zsh-hook -Uz preexec __title_preexec
fi

add-zsh-hook -Uz precmd __title_cwd
