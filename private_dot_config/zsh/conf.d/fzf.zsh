# fzf config
export FZF_DEFAULT_OPTS="--layout=reverse
--cycle
--border=rounded
--preview-window=rounded
--info=default"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
--color=fg:#c2c2c2,bg:-1,hl:#c678dd
--color=fg+:#d7dae0,bg+:#282c34,hl+:#de73ff
--color=info:#e5c07b,prompt:#a5e075,pointer:#4dc4ff
--color=marker:#e06c75,spinner:#98c379,header:#4cd1e0
--color=border:#3f4451"

# zoxide fzf config
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS
--preview='eza --all\
  --ignore-glob .git --classify\
  --tree --level 2\
  --color=always --icons=always\
  --group-directories-first {2..}\
  | head -200'
--height=50%
--cycle"

# zman fzf config
_zman_fzf_opts=('--height=60%')
