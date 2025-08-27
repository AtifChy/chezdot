# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# disable welcome message
$env.config.show_banner = false

# prompt config
oh-my-posh init nu --config ($nu.home-path | path join .config/oh-my-posh/my-theme.omp.toml)

# set default editor
$env.EDITOR = "nvim"

# enable vi mode
# $env.config.edit_mode = "vi"

# vi mode cursor shape
# $env.config.cursor_shape = {
#   vi_insert: line,
#   vi_normal: block,
# }

# bat theme
$env.BAT_THEME = "Catppuccin Macchiato"

## completions
$env.config.completions.algorithm = 'substring'

use completions/btm-completions.nu *
use completions/chezmoi-completion.nu *
use completions/sudo-completions.nu *
use completions/uvx-completions.nu *
use completions/wsl-completions.nu *
use completions/yasbc-completions.nu *
use completions/oh-my-posh-completions.nu *

use custom-completions/bitwarden-cli/bitwarden-cli-completions.nu *
use custom-completions/komorebi/komorebi-completions.nu *
use custom-completions/scoop/scoop-completions.nu *
use custom-completions/uv/uv-completions.nu *
use custom-completions/vscode/vscode-completions.nu *
use custom-completions/winget/winget-completions.nu *

## aliases
# NOTE: Define aliases after completions to ensure alias completions work correctly
alias cat = bat --style=plain --paging=never
# alias ff = fastfetch
# alias v = nvim
alias htop = ntop
alias vimdiff = nvim -d
alias ll = ls --all

alias rm = rm --verbose
alias mv = mv --verbose
alias cp = cp --verbose
alias mkdir = mkdir --verbose

use aliases/git.nu *
use aliases/chezmoi/chezmoi-aliases.nu *

let abbr = {
  ff: fastfetch,
  v: nvim,
}

## carapace config
$env.CARAPACE_MATCH = "CASE_INSENSITIVE"
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,powershell,inshellisense'

# fzf config
$env.FZF_DEFAULT_OPTS = '
--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796
--color=fg:#CAD3F5,header:#ED8796,info:#F5C2E7,pointer:#89B4FA
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796
--color=selected-bg:#494D64
--color=border:#363A4F,label:#CAD3F5'

$env.FZF_DEFAULT_OPTS = $env.FZF_DEFAULT_OPTS + '
--layout=reverse
--cycle
--border=rounded
--preview-window=rounded
--info=default'

$env._ZO_FZF_OPTS = $env.FZF_DEFAULT_OPTS + "
--preview='eza --all --ignore-glob .git --tree --level 2 --color=always --icons=always --group-directories-first {2..} | head -200'
--height=50%
--cycle"

# File Explorer
def explorer [
  path: path # Path to open in Explorer
] {
  ^explorer.exe $path
}

$env.HOME = $env.USERPROFILE
