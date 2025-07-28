export extern "uvx" [
  --from: string                        # Use the given package to provide the command
  --with: string                        # Run with the given packages installed
  --with-editable: string               # Run with the given packages in editable mode
  --with-requirements: string           # Run with packages from given requirements.txt files
  --constraints(-c): string             # Constrain versions using requirement files [env: UV_CONSTRAINT]
  --build-constraints(-b): string       # Constrain build deps when building sdists [env: UV_BUILD_CONSTRAINT]
  --overrides: string                   # Override versions via requirements files [env: UV_OVERRIDE]
  --isolated                            # Run in isolated virtualenv, ignoring installed tools
  --env-file: string                    # Load env vars from a `.env` file [env: UV_ENV_FILE]
  --no-env-file                         # Avoid reading env vars from `.env` [env: UV_NO_ENV_FILE]
  --version(-V)                         # Display version

  # Index options
  --index: string                       # Extra index URLs [env: UV_INDEX]
  --default-index: string               # Default package index URL [env: UV_DEFAULT_INDEX]
  --index-url(-i): string               # (Deprecated) Use `--default-index` instead [env: UV_INDEX_URL]
  --extra-index-url: string             # (Deprecated) Use `--index` instead [env: UV_EXTRA_INDEX_URL]
  --find-links(-f): string              # Additional locations for package distributions [env: UV_FIND_LINKS]
  --no-index                            # Ignore registry index (e.g. PyPI)
  --index-strategy: string              # Strategy for resolving multiple index URLs [env: UV_INDEX_STRATEGY]
  --keyring-provider: string            # Keyring auth strategy [env: UV_KEYRING_PROVIDER]

  # Resolver options
  --upgrade(-U)                         # Allow upgrades (implies --refresh)
  --upgrade-package(-P): string         # Upgrade only specific packages
  --resolution: string                  # Version resolution strategy [env: UV_RESOLUTION]
  --prerelease: string                  # Pre-release handling strategy [env: UV_PRERELEASE]
  --fork-strategy: string               # Strategy for resolving forks [env: UV_FORK_STRATEGY]
  --exclude-newer: string               # Limit to packages uploaded before this date [env: UV_EXCLUDE_NEWER]
  --no-sources                          # Ignore `tool.uv.sources` table

  # Installer options
  --reinstall                           # Reinstall all packages (implies --refresh)
  --reinstall-package: string           # Reinstall a specific package
  --link-mode: string                   # Install method from global cache [env: UV_LINK_MODE]
  --compile-bytecode                    # Compile Python files to bytecode [env: UV_COMPILE_BYTECODE]

  # Build options
  --config-setting(-C): string          # PEP 517 build settings as `KEY=VALUE`
  --no-build-isolation                  # Disable build isolation [env: UV_NO_BUILD_ISOLATION]
  --no-build-isolation-package: string  # Disable isolation for specific package
  --no-build                            # Don't build source distributions [env: UV_NO_BUILD]
  --no-build-package: string            # Don't build source dists for specific package
  --no-binary                           # Don't install wheels [env: UV_NO_BINARY]
  --no-binary-package: string           # Don't install wheels for specific package

  # Cache options
  --no-cache(-n)                        # Avoid cache usage [env: UV_NO_CACHE]
  --cache-dir: string                   # Path to cache directory [env: UV_CACHE_DIR]
  --refresh                             # Refresh all cached data
  --refresh-package: string             # Refresh cache for specific package

  # Python options
  --python(-p): string                  # Python interpreter to use [env: UV_PYTHON]
  --managed-python                      # Require uv-managed Python [env: UV_MANAGED_PYTHON]
  --no-managed-python                   # Disable uv-managed Python [env: UV_NO_MANAGED_PYTHON]
  --no-python-downloads                 # Disable Python auto-downloads [env: UV_PYTHON_DOWNLOADS=never]

  # Global options
  --quiet(-q)                           # Quiet output
  --verbose(-v)                         # Verbose output
  --color: string                       # Color output control [auto, always, never]
  --native-tls                          # Use native cert store [env: UV_NATIVE_TLS]
  --offline                             # Disable network access [env: UV_OFFLINE]
  --allow-insecure-host: string         # Allow insecure connection [env: UV_INSECURE_HOST]
  --no-progress                         # Hide progress output [env: UV_NO_PROGRESS]
  --directory: string                   # Change to this directory before running command
  --project: string                     # Run within given project directory [env: UV_PROJECT]
  --config-file: string                 # Path to `uv.toml` config file [env: UV_CONFIG_FILE]
  --no-config                           # Disable config file discovery [env: UV_NO_CONFIG]
  --help(-h)                            # Show concise help
]
