# Nushell completion for oh-my-posh

# To use, run:
# source oh-my-posh-completions.nu

# --- Helper functions for completions ---

# A list of shells oh-my-posh can initialize
def "nu-complete oh-my-posh shells" [] {
  [bash zsh fish powershell pwsh cmd nu elvish xonsh]
}

# A list of output formats
def "nu-complete oh-my-posh formats" [] {
  [json toml yaml]
}

# A list of values for the 'get' command
def "nu-complete oh-my-posh get-values" [] {
  [shell millis accent toggles width uuid]
}

# A best-effort list of installable nerd fonts
def "nu-complete oh-my-posh font-names" [] {
  [
    "3270"
    "Agave"
    "AnonymousPro"
    "Arimo"
    "AurulentSansMono"
    "BigBlueTerminal"
    "BitstreamVeraSansMono"
    "CascadiaCode"
    "CodeNewRoman"
    "ComicShannsMono"
    "Cousine"
    "DaddyTimeMono"
    "DejaVuSansMono"
    "DroidSansMono"
    "EnvyCodeR"
    "FantasqueSansMono"
    "FiraCode"
    "FiraMono"
    "Go-Mono"
    "Gohu"
    "Hack"
    "Hasklig"
    "HeavyData"
    "Hermit"
    "iA-Writer"
    "IBMPlexMono"
    "Inconsolata"
    "InconsolataGo"
    "InconsolataLGC"
    "Iosevka"
    "IosevkaTerm"
    "JetBrainsMono"
    "Lekton"
    "LiberationMono"
    "Lilex"
    "MPlus"
    "Meslo"
    "Monofur"
    "Monoid"
    "Mononoki"
    "Noto"
    "OperatorMono"
    "Overpass"
    "ProFont"
    "ProggyClean"
    "RobotoMono"
    "ShareTechMono"
    "SourceCodePro"
    "SpaceMono"
    "Terminus"
    "Tinos"
    "Ubuntu"
    "UbuntuMono"
    "VictorMono"
  ]
}


# --- Main command and global flags ---

# A cross platform tool to render your prompt
export extern "oh-my-posh" [
  --config(-c): path   # config file path
  --help(-h)            # help for oh-my-posh
  --init(-i)            # init
  --shell(-s): string@"nu-complete oh-my-posh shells" # shell
  --version             # print the version number and exit
]

# --- Subcommands ---

# Authenticate against a service
export extern "oh-my-posh auth" [
  --config(-c): path   # config file path
  --help(-h) # help for auth
]

# Interact with the oh-my-posh cache
export extern "oh-my-posh cache" [
  args: string@"nu-complete oh-my-posh cache-subcommands" # subcommands: path, clear, edit
  --config(-c): path   # config file path
  --help(-h) # help for cache
]
def "nu-complete oh-my-posh cache-subcommands" [] { [path clear edit] }


# Interact with the config
export extern "oh-my-posh config" [
  args: string@"nu-complete oh-my-posh config-subcommands" # subcommands: export, migrate, edit
  --config(-c): path   # config file path
  --help(-h) # help for config
]
def "nu-complete oh-my-posh config-subcommands" [] { [export migrate edit] }

# Edit your config
export extern "oh-my-posh config edit" [
  --config(-c): path   # config file path
  --help(-h) # help for edit
]

# Export your config
export extern "oh-my-posh config export" [
  --config(-c): path   # config file path
  --format(-f): string@"nu-complete oh-my-posh formats" # config format to migrate to (default "json")
  --output(-o): path                                   # config file to export to
  --help(-h)                                           # help for export
]

# Export your config to an image
export extern "oh-my-posh config export image" [
  --config(-c): path   # config file path
  --output(-o): path     # image file (.png) to export to
  --settings: path      # color settings file to override ANSI color codes and metadata
  --help(-h)              # help for image
]

# Migrate your config
export extern "oh-my-posh config migrate" [
  --config(-c): path   # config file path
  --format(-f): string@"nu-complete oh-my-posh formats" # the config format to migrate to (default "json")
  --write(-w)                                          # write the migrated config back to the config file
  --help(-h)                                           # help for migrate
]

# Migrate the nerd font glyphs in your config
export extern "oh-my-posh config migrate glyphs" [
  --config(-c): path   # config file path
  --format(-f): string@"nu-complete oh-my-posh formats" # the config format to migrate to
  --write(-w)                                          # write the migrated config back to the config file
  --help(-h)                                           # help for glyphs
]

# Print the prompt in debug mode
export extern "oh-my-posh debug" [
  --config(-c): path   # config file path
  --help(-h) # help for debug
]

# Disable a feature
export extern "oh-my-posh disable" [
  --config(-c): path   # config file path
  --help(-h) # help for disable
]

# Enable a feature
export extern "oh-my-posh enable" [
  --config(-c): path   # config file path
  --help(-h) # help for enable
]

# Manage fonts
export extern "oh-my-posh font" [
  --config(-c): path   # config file path
  --zip-folder: path # the folder inside the zip file to install fonts from
  --help(-h)         # help for font
]

# Install a font
export extern "oh-my-posh font install" [
  font_name: string@"nu-complete oh-my-posh font-names" # The name of the font to install
  --config(-c): path   # config file path
  --help(-h) # help for install
]

# Configure a font
export extern "oh-my-posh font configure" [
  font_name: string@"nu-complete oh-my-posh font-names" # The name of the font to install
  --config(-c): path   # config file path
  --help(-h) # help for install
]

# Get a value from oh-my-posh
export extern "oh-my-posh get" [
  value: string@"nu-complete oh-my-posh get-values" # The value to get
  --config(-c): path   # config file path
  --shell: string@"nu-complete oh-my-posh shells"   # the shell to print for
  --help(-h)                                       # help for get
]

# Help about any command
export extern "oh-my-posh help" []

# Initialize your shell and config
export extern "oh-my-posh init" [
  shell: string@"nu-complete oh-my-posh shells" # The shell to initialize for
  --config(-c): path   # config file path
  --debug    # enable/disable debug mode
  --eval     # output the prompt for eval
  --print(-p)    # print the init script
  --strict(-s)   # run in strict mode
  --help(-h)     # help for init
]

# Print the upgrade notice when a new version is available.
export extern "oh-my-posh notice" [
  --config(-c): path   # config file path
  --help(-h) # help for notice
]

# Print the prompt/context
export extern "oh-my-posh print" [
  args: string@"nu-complete oh-my-posh print-options" # options: debug, primary, secondary, transient, right, tooltip, valid, error, preview
  --config(-c): path   # config file path
  --cleared                # do we have a clear terminal or not
  --column: int             # the column position of the cursor
  --command: string         # tooltip command
  --escape                 # escape the ANSI sequences for the shell (default true)
  --eval                   # output the prompt for eval
  --execution-time: float   # timing of the last command
  --force(-f)                  # force rendering the segments
  --help(-h)                   # help for print
  --job-count: int          # number of background jobs
  --no-status              # no valid status code (cancelled or no command yet)
  --pipestatus: string      # the PIPESTATUS array
  --plain(-p)                  # plain text output (no ANSI)
  --pswd: path            # current working directory (according to pwsh)
  --pwd: path             # current working directory
  --shell: string@"nu-complete oh-my-posh shells"           # the shell to print for
  --shell-version: string   # the shell version
  --stack-count(-s): int        # number of locations on the stack
  --status: int             # last known status code
  --terminal-width(-w): int     # width of the terminal
]
def "nu-complete oh-my-posh print-options" [] { [debug primary secondary transient right tooltip valid error preview] }


# Toggle one or more segments on/off
export extern "oh-my-posh toggle" [
  segment_names: string # The names of the segments to toggle
  --config(-c): path   # config file path
  --help(-h) # help for toggle
]

# Upgrade when a new version is available.
export extern "oh-my-posh upgrade" [
  --config(-c): path   # config file path
  --help(-h) # help for upgrade
]

# Print the version
export extern "oh-my-posh version" []
