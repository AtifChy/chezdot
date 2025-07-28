def "nu-complete yasbc" [] {
  [
    { value: "start", description: "Start the application" }
    { value: "stop", description: "Stop the application" }
    { value: "reload", description: "Reload the application" }
    { value: "enable-autostart", description: "Enable autostart on system boot" }
    { value: "disable-autostart", description: "Disable autostart on system boot" }
    { value: "monitor-information", description: "Show information about connected monitors" }
    { value: "show-bar", description: "Show the bar on all or a specific screen" }
    { value: "hide-bar", description: "Hide the bar on all or a specific screen" }
    { value: "toggle-bar", description: "Toggle the bar on all or a specific screen" }
    { value: "update", description: "Update the application" }
    { value: "log", description: "Tail yasb process logs (cancel with Ctrl-C)" }
    { value: "reset", description: "Restore default config files and clear cache" }
    { value: "help", description: "Print help message" }
  ]
}

# Completion for show/hide/toggle-bar --screen
def "nu-complete screen" [] {
  # Replace this with dynamic detection if needed
  []
}

export extern "yasbc" [
  command?: string@"nu-complete yasbc"
  --version(-v)    # Print version
  --help(-h)       # Print help message
]

export extern "yasbc start" [
  --silent(-s)     # Silence print messages
  --help(-h)       # Show help message
]

export extern "yasbc stop" [
  --silent(-s)     # Silence print messages
  --force(-f)      # Force stop the application
  --help(-h)       # Show help message
]

export extern "yasbc reload" [
  --silent(-s)     # Silence print messages
  --help(-h)       # Show help message
]

export extern "yasbc enable-autostart" [
  --task           # Enable autostart as a scheduled task
  --help(-h)       # Show help message
]

export extern "yasbc disable-autostart" [
  --task           # Disable autostart as a scheduled task
  --help(-h)       # Show help message
]

export extern "yasbc monitor-information" [
  --help(-h)       # Show help message
]

export extern "yasbc show-bar" [
  --screen(-s): string@"nu-complete screen"   # Screen name (optional)
  --help(-h)                                  # Show help message
]

export extern "yasbc hide-bar" [
  --screen(-s): string@"nu-complete screen"   # Screen name (optional)
  --help(-h)                                  # Show help message
]

export extern "yasbc toggle-bar" [
  --screen(-s): string@"nu-complete screen"   # Screen name (optional)
  --help(-h)                                  # Show help message
]

export extern "yasbc update" [
  --help(-h)       # Show help message
]

export extern "yasbc log" [
  --help(-h)       # Show help message
]

export extern "yasbc reset" [
  --help(-h)       # Show help message
]
