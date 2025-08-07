def chdot [
  query?: string  # Initial query string
] {
  let required = [chezmoi bat fzf]
  for cmd in $required {
    if (which $cmd | is-empty) {
      error make { msg: $"Required command '($cmd)' not found. Please install it." }
    } else {
      # print $"Command '($cmd)' is available."
    }
  }
 
  let files = (^chezmoi managed --include=files --exclude=externals --path-style=relative | lines)
 
  let timestamps = (
    $files
    | where {|f| ($env.USERPROFILE | path join $f | path exists) }
    | each {|f|
      let path = ($env.USERPROFILE | path join $f)
      let stat = (ls -s $path | get modified.0)
      { ts: $stat, file: $f }
    }
  )
 
  let sorted = ($timestamps | sort-by -r ts)
 
  let select = (
    $sorted
    | get file
    | str join "\n"
    | ^fzf --query=($query) --multi --height=60% --preview="bat --style=plain --paging=never --color=always --line-range=:200 %USERPROFILE%/{}"
    | lines
  )
 
  if ($select | is-empty) {
    return
  }
 
  ^chezmoi edit --apply ...($select | each {|f| $env.USERPROFILE | path join $f})
}
