$env.config.keybindings = $env.config.keybindings | append [
  {
    name: abbr_menu
    modifier: none
    keycode: enter
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { send: menu name: abbr_menu }
      { send: enter }
    ]
  }
  {
    name: abbr_menu
    modifier: none
    keycode: space
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { send: menu name: abbr_menu }
      { edit: insertchar value: ' '}
    ]
  }
]

$env.config.menus = $env.config.menus | append [
  {
    name: abbr_menu
    only_buffer_difference: false
    marker: none
    type: {
      layout: columnar
      columns: 1
      col_width: 20
      col_padding: 2
    }
    style: {
      text: green
      selected_text: green_reverse
      description_text: yellow
    }
    source: { |buffer, position|
      let separators = [';' '|' '(' '{']
      mut last_sep_pos = -1

      for sep in $separators {
        let pos = ($buffer | str index-of --end $sep)
        if $pos > $last_sep_pos {
          $last_sep_pos = $pos
        }
      }

      let is_whole = ($last_sep_pos == -1)
      let prefix = if $is_whole { "" } else { $buffer | str substring 0..$last_sep_pos }
      let last_part = if $is_whole { $buffer } else { $buffer | str substring ($last_sep_pos + 1).. }

      let current_cmd = ($last_part | str trim | split row ' ' | first)
      let match = ($abbr | get -o $current_cmd)

      if ($match | is-empty) {
        {value: $buffer}
      } else {
        {value: ($prefix + ($last_part | str replace $current_cmd $match))}
      }
    }
  }
]
