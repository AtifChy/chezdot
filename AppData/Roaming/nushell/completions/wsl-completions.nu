export extern "wsl" [
  # Running Linux binaries
  --exec(-e): string                              # Execute the specified command (no shell)
  --shell-type: string@"nu-complete shell-type"   # Shell type: standard | login | none
  --cd: path                                      # Set current working directory
  --distribution(-d): string@"nu-complete installed-distros" # Run specified distribution
  --distribution-id: string                       # Run specified distro by GUID
  --user(-u): string                              # Run as specific user
  --system                                        # Launch shell for the system distribution

  # Install options
  --install: string@"wsl --install"               # Install a distribution (positional)

  # Manage distro
  --manage: string@"wsl --manage"                 # Manage distro (positional)

  # Mount/unmount disks
  --mount: path@"wsl --mount"                     # Mount physical/virtual disk (positional)
  --unmount: path                                 # Unmount one or all disks

  # Export/import
  --export: string@"wsl --export"                 # Distro to export (positional)
  --import: string@"wsl --import"                 # Distro to import (positional)
  --import-in-place: string                       # Import VHDX directly

  # General distro management
  --list(-l):string@"wsl --list"                  # List distributions
  --set-default(-s): string@"nu-complete installed-distros" # Set default distro
  --set-default-version: int                      # Set default version for new distros
  --set-version: string                           # Set version for a distro (needs 2 args)
  --terminate(-t): string@"nu-complete running-distros" # Terminate a distro
  --unregister: string@"nu-complete installed-distros" # Unregister distro

  # Maintenance
  --shutdown                                      # Stop all distros and WSL VM
  --status                                        # Show WSL status
  --update: string@"wsl --update"                 # Update WSL package
  --uninstall                                     # Uninstall WSL itself

  # Misc
  --help                                          # Show help
  --version(-v)                                   # Show WSL version
]

# Install a Windows Subsystem for Linux distribution
export extern "wsl --install" [
  distro?: string@"nu-complete online-distros"     # Install a distro (positional)
  --enable-wsl1                                   # Enable WSL1 support
  --fixed-vhd                                     # Create fixed-size VHD
  --from-file: path                               # Install from local file
  --legacy                                        # Use legacy manifest
  --location: path                                # Set install path
  --name: string@"nu-complete online-distros"     # Name for new distro
  --no-distribution                               # Don't install a distro
  --no-launch(-n)                                 # Don't launch after install
  --version: int                                  # Set distro version (1 or 2)
  --vhd-size: string                              # Size of virtual disk (e.g., 1GB)
  --web-download                                  # Download from web, not Store
]

# Changes distro specific options
export extern "wsl --manage" [
  --move: path                                    # Move distro location
  --set-sparse(-s): string                        # true or false
  --set-default-user: string                      # Set default user
  --resize: string                                # Resize disk (e.g., 10GB)
]

# Attaches and mounts a physical or virtual disk in all WSL 2 distributions
export extern "wsl --mount" [
  --vhd                                           # Mark disk as virtual
  --bare                                          # Attach but don’t mount
  --name: string                                  # Custom name for mountpoint
  --type: string                                  # Filesystem type (e.g., ext4)
  --options: string                               # Extra mount options
  --partition: int                                # Which partition to mount
]

# Exports the distribution
export extern "wsl --export" [
  --format: string@"nu-complete export-format"    # tar, tar.gz, tar.xz, vhd
]

# Imports the specified tar file as a new distribution
export extern "wsl --import" [
  --vhd                                           # Import VHDX instead of tar
  --version: int                                  # Specifies the version to use for the new distribution.
]

# Lists distributions
export extern "wsl --list" [
  --all                                           # List all distros
  --running                                       # Only running distros
  --quiet(-q)                                     # Only show names
  --verbose(-v)                                   # Detailed output
  --online(-o)                                    # List distros available for install
]

# Update the Windows Subsystem for Linux package
export extern "wsl --update" [
  --pre-release                                   # Use prerelease when updating
]

# Lists available distributions for installation
export def "wsl --list --online" [] {
  ^wsl.exe --list --online
  | decode utf-16le
  | lines
  | skip 4
  | parse --regex '^(?P<name>\S+)\s+(?P<friendly_name>.+)$'
}

# Shows the status of WSL
export def "wsl --list --verbose" [] {
  ^wsl --list --verbose
  | decode utf-16le
  | lines
  | skip 1
  | parse --regex '(?P<name>.+)\s+(?P<state>\S+)\s+(?P<version>.+)'
}

def "nu-complete online-distros" [] {
  wsl --list --online
  | each {|distro|
  { value: $distro.name, description: $distro.friendly_name }
  }
}

def "nu-complete installed-distros" [] {
  ^wsl.exe --list --quiet
  | decode utf-16le
  | lines
}

def "nu-complete running-distros" [] {
  ^wsl.exe --list --running --quiet
  | decode utf-16le
  | lines
}

def "nu-complete shell-type" [] {
  [standard login none]
}

def "nu-complete export-format" [] {
  [tar tar.gz tar.xz vhd]
}
