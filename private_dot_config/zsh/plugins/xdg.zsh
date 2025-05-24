# docker
export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
export MACHINE_STORAGE_PATH="${MACHINE_STORAGE_PATH:-$XDG_DATA_HOME/docker-machine}"

# wget
export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgetrc}"
if [[ ! -f $WGETRC || ! -s $WGETRC ]]; then
  mkdir -p ${WGETRC:h}
  print hsts-file=$XDG_CACHE_HOME/wget-hsts >> $WGETRC
fi

# node
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/node/repl_history}"
if [[ ! -f $NODE_REPL_HISTORY ]]; then
  mkdir -p ${NODE_REPL_HISTORY:h}
fi
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
if [[ ! -f $NPM_CONFIG_USERCONFIG || ! -s $NPM_CONFIG_USERCONFIG ]]; then
  mkdir -p ${NPM_CONFIG_USERCONFIG:h}
  {
    print -r -- '# npmrc config'
    print -r -- "prefix=$XDG_DATA_HOME/npm"
    print -r -- "cache=$XDG_CACHE_HOME/npm"
    print -r -- "init-module=$XDG_CONFIG_HOME/npm/config/init.js"
    print -r -- "logs-dir=$XDG_STATE_HOME/npm/logs"
  } > $NPM_CONFIG_USERCONFIG
fi

# go
export GOPATH="${GOPATH:-$XDG_DATA_HOME/go}"
export GOBIN="${GOBIN:-$GOPATH/bin}"
path+=($GOBIN)

# rust
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"

# sqlite
export SQLITE_HISTORY="${SQLITE_HISTORY:-$XDG_DATA_HOME/sqlite/history}"
[[ ! -d ${SQLITE_HISTORY:h} ]] && mkdir -p ${SQLITE_HISTORY:h}

# git
() {
  local git_cfg ext src
  git_cfg=$XDG_CONFIG_HOME/git
  [[ ! -d $git_cfg ]] && mkdir -p $git_cfg
  for ext in git{config,ignore,attributes,-credentials,k}; do
    src=$HOME/.${ext}
    [[ -f $src ]] || continue
    case $ext in
      'gitk') mv -b $src $git_cfg/gitk ;;
      'git-credentials') mv -b $src $git_cfg/credentials;;
      *) mv -b $src $git_cfg/${ext//.git/} ;;
    esac
  done
}

# revolver
export REVOLVER_DIR="${REVOLVER_DIR:-$XDG_DATA_HOME/revolver}"
