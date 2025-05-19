function command_not_found_handler() {
  local cmd=$1
  local -a pkgs pkg

  local -A repo_colors
  repo_colors=(
    [core]="magenta"
    [extra]="blue"
    [multilib]="green"
  )

  pkgs=(${(f)"$(CLICOLOR=0 filkoll binary --no-fuzzy-if-exact -- "$cmd" 2>/dev/null)"})
 
  if [[ -n $pkgs ]]; then
    local -i max_prefix max_path
    local repo name ver path others prefix

    print -Pr -- "%B$cmd%b may be found in the following packages:"
 
    # 1) Compute max widths
    for pkg in ${(@)pkgs}; do
      pkg=(${(s: :)pkg})
      path=${pkg[3]}
      prefix=$(( ${#pkg[1]} + ${#pkg[2]} + 2 ))
 
      (( ${prefix}  > max_prefix )) && max_prefix=${prefix}
      (( ${#path}   > max_path   )) && max_path=${#path}
    done
 
    # 2) Print aligned columns
    for pkg in ${(@)pkgs}; do
      pkg=(${(s: :)pkg})
      repo=${pkg[1]%%/*}
      repo_color=${repo_colors[$repo]:-cyan}
      name=${pkg[1]##*/}
      ver=${pkg[2]}
      path=${pkg[3]}
      others=${pkg[4,-1]}
      prefix=$(( ${#pkg[1]} + ${#pkg[2]} + 2 ))
 
      # a) colored prefix
      print -Prn -- "  %B%F{${repo_color}}${repo}/%F{white}${name} %F{green}${ver}%f%b"
 
      # b) pad so path always starts at column
      pad=$(( max_prefix - ${prefix} + 3 ))
      printf "%${pad}s" ""
 
      # c) fixed-width path + extras
      printf "%-${max_path}s  %s\n" "$path" "$others"
    done
  else
    print -rn -- "zsh: command not found: $cmd"
  fi >&2

  return 127
}

# function command_not_found_handler {
#   local pkgs cmd="$1"
#
#   pkgs=(${(f)"$(pkgfile -bvw -- "$cmd" 2>/dev/null)"})
#
#   if [[ -n "$pkgs" ]]; then
#     local pkg repo name version bin
#     printf '\e[1;34m%s\e[0m may be found in the following packages:\n' "$cmd"
#     for pkg in $pkgs[@]; do
#       pkg=(${=pkg})
#       repo=${pkg[1]%%/*}
#       name=${pkg[1]##*/}
#       version=$pkg[2]
#       bin=$pkg[3]
#       printf '  \e[35;1m%s/\e[37;1m%s \e[32;1m%s\e[0m \t%s\n' \
#         "$repo" "$name" "$version" "$bin"
#     done
#   else
#     printf 'zsh: command not found: %s\n' "$cmd"
#   fi 1>&2
#
#   return 127
# }
