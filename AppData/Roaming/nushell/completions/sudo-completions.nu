export extern "sudo" [
  command: string@"nu-complete sudo-subcommands"  # Subcommand to run
  ...args                                         # Additional arguments or command-line to execute
  --preserve-env(-E)      # Pass the current environment variables to the command
  --new-window(-N)        # Use a new window for the command
  --disable-input         # Run in the current terminal with input disabled
  --inline                # Run in the current terminal
  --chdir(-D): path       # Change the working directory before running the command
  --help(-h)              # Print help
  --version(-V)           # Print version
]

def "nu-complete sudo-subcommands" [] {
  [
    { value: "run", description: "Run a command as admin" }
    { value: "config", description: "Get current configuration information of sudo" }
    { value: "help", description: "Print help message for sudo or a specific subcommand" }
  ]
}
