def "cargo-make task" []: nothing -> list<record<value: string, description: string>> {
  open Makefile.toml
  | get tasks
  | transpose name properties
  | where { not ('private' in $in.properties and $in.properties.private) }
  | each {|it|
    let description = if 'description' in $it.properties { $it.properties.description } else { null }
    { value: $it.name, description: $description }
  }
}

def "cargo-make loglevel" []: nothing -> list<string> {
  ["verbose", "info", "error"]
}

def "cargo-make output-format" []: nothing -> list<string> {
  ["default", "short-description", "markdown", "markdown-single-page", "markdown-sub-section", "autocomplete"]
}

# Rust task runner and build tool
export extern "cargo make" [
  task?: string@"cargo-make task"                        # The task to execute
  ...task_args: string                                   # Arguments which can be accessed in the task itself
  --help (-h)                                            # Print help information
  --version (-V)                                         # Print version information
  --makefile: path                                       # The optional toml file containing the tasks definitions
  --task (-t): string@"cargo-make task" = "default"      # The task name to execute (can omit the flag if the task name is the last argument)
  --profile (-p): string = "development"                 # The profile name (will be converted to lower case)
  --cwd: path                                            # Will set the current working directory. The search for the makefile will be from this directory if defined.
  --no-workspace                                         # Disable workspace support (tasks are triggered on workspace and not on members)
  --no-on-error                                          # Disable on error flow even if defined in config sections
  --allow-private                                        # Allow invocation of private tasks
  --skip-init-end-tasks                                  # If set, init and end tasks are skipped
  --skip-tasks: string                                   # Skip all tasks that match the provided regex (example: pre.*|post.*)
  --env-file: path                                       # Set environment variables from provided file
  --env (-e): string                                     # Set environment variables
  --loglevel (-l): string@"cargo-make loglevel" = "info" # The log level
  --verbose (-v)                                         # Sets the log level to verbose (shorthand for --loglevel verbose)
  --quiet                                                # Sets the log level to error (shorthand for --loglevel error)
  --no-color                                             # Disables colorful output
  --time-summary                                         # Print task level time summary at end of flow
  --experimental                                         # Allows access unsupported experimental predefined tasks.
  --disable-check-for-updates                            # Disables the update check during startup
  --output-format: string@"cargo-make output-format"     # The print/list steps format (some operations do not support all formats)
  --output-file: path                                    # The list steps output file name
  --print-steps                                          # Only prints the steps of the build in the order they will be invoked but without invoking them
  --list-all-steps                                       # Lists all known steps
  --list-category-steps: string                          # List steps for a given category
  --diff-steps                                           # Runs diff between custom flow and prebuilt flow (requires git)
]
