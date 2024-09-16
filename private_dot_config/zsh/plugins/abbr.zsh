# Based on https://github.com/momo-lab/zsh-abbrev-alias

typeset -gA __abbrs
typeset -gi ABBR_TIPS_STATUS

function __abbr_register {
  local kind=$1 key=${2%%=*} value=${2#*=}
  case $kind in
    g) alias -g $key=$value ;;
    c) alias $key=$value ;;
    *) return 1 ;;
  esac
  __abbrs[$key]="$kind\0$value"
}

function __abbr_expand {
  local word=${${(Az)LBUFFER}[-1]}
  local abbr=${__abbrs[$word]}
  if [[ -n $abbr ]]; then
    zle _expand_alias
    ABBR_TIPS_STATUS=0
  fi
}

function __abbr_expand_and_insert {
  zle __abbr_expand
  zle self-insert
}

function __abbr_expand_and_accept_line {
  zle __abbr_expand
  zle accept-line
}

function __abbr_expand_and_end_of_line {
  zle __abbr_expand
  zle end-of-line
}

function __abbr_no_expand {
  LBUFFER+=' '
}

function __abbr_init {
  zle -N __abbr_expand
  zle -N __abbr_expand_and_insert
  zle -N __abbr_no_expand
  zle -N __abbr_expand_and_accept_line
  zle -N __abbr_expand_and_end_of_line
  bindkey ' '    __abbr_expand_and_insert
  bindkey '^ '   __abbr_no_expand
  bindkey '^M'   __abbr_expand_and_accept_line
  bindkey '^[[F' __abbr_expand_and_end_of_line
}

function __abbr_show {
  local kind_filter=$1
  local key=$2
  local abbr=${__abbrs[$key]}
  [[ -n $abbr ]] || return 1
  local kind=${${(s.\0.)abbr}[1]}
  local value=${${(s.\0.)abbr}[2]}
  if [[ $kind_filter == $kind ]]; then
    print "${(q+)key}=${(q+)value}"
  fi
  return 0
}

function __abbr_list {
  local kind_filters=$1
  for kind_filter in ${(s::)kind_filters}; do
    for key in ${(ko)__abbrs}; do
      __abbr_show $kind_filter $key
    done
  done
}

function __abbr_unregister {
  local key=$1
  if [[ -n $__abbrs[$key] ]]; then
    unalias $key
    unset "__abbrs[$key]"
  else
    print "abbr: $key: not found" >&2
    return 1
  fi
}

function __abbr_help {
  print -P "%B%F{blue}abbr%f%b is a command to manage abbreviations.

%U%BUSAGE:%b%u
  abbr [options] {name=value ...}
  abbr -u {name ...}

%U%BOPTIONS:%b%u
  -c, --command       register alias as 'alias name=value' [default]
  -g, --global        register alias as 'alias -g name=value'
  -u, --unset         unset abbreviation
  -h, --help          show this help"
}

function abbr {
  zparseopts -D -F -- \
    {h,-help}=help \
    {u,-unset}=unset \
    {c,-command}=command \
    {g,-global}=global

  if (( $#help )); then
    __abbr_help
    return 0
  fi

  if (( $#unset )); then
    for key in $@; do
      __abbr_unregister $key
    done
    return 0
  fi

  local kind
  if (( $#command )); then
    kind=c
  elif (( $#global )); then
    kind=g
  fi

  if (( ! $# )); then
    __abbr_list ${kind:-gc}
    return 0
  fi

  local result=0
  while (( $# )); do
    if [[ $1 =~ "=" ]]; then
      __abbr_register ${kind:-c} $1
    else
      __abbr_show ${kind:-c} $1
      if [[ $? != 0 ]]; then
        result=1
      fi
    fi
    shift
  done
  return $result
}

__abbr_init
# unfunction __abbr_init
