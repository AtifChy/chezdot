# Manage clipboard
def clipboard [] {}

# Copy to clipboard
def "clipboard copy" [...rest: string] {
  ^win32yank.exe -i ...$rest
}

# Paste from clipboard
def "clipboard paste" [] {
  ^win32yank.exe -o
}
