module completions {
    # Like du but more intuitive
    export extern "dust" [
        --depth (-d): int # Depth to show
        --threads (-T): int # Number of threads to use
        --config: path # Specify a config file to use
        --number-of-lines (-n): int # Number of lines of output to show. (Default is terminal_height - 10)
        --full-paths (-p) # Subdirectories will not have their path shortened
        --ignore-directory (-X): list<path> # Exclude any file or directory with this path
        --ignore-all-in-file (-I): string # Exclude any file or directory with a regex matching that listed in this file, the file entries will be added to the ignore regexs provided by --invert-filter
        --dereference-links (-L) # dereference sym links - Treat sym links as directories and go into them
        --limit-filesystem (-x) # Only count the files and directories on the same filesystem as the supplied directory
        --apparent-size (-s) # Use file length instead of blocks
        --reverse (-r) # Print tree upside down (biggest highest)
        --no-colors (-c) # No colors will be printed (Useful for commands like: watch)
        --force-colors (-C) # Force colors print
        --no-percent-bars (-b) # No percent bars or percentages will be displayed
        --bars-on-right (-B) # percent bars moved to right side of screen
        --min-size (-z): filesize # Minimum size file to include in output
        --screen-reader (-R) # For screen readers. Removes bars. Adds new column: depth level (May want to use -p too for full path)
        --skip-total # No total row will be displayed
        --filecount (-f) # Directory 'size' is number of child files instead of disk size
        --ignore-hidden (-i) # Do not display hidden files
        --invert-filter (-v): list<string> # Exclude filepaths matching this regex. To ignore png file types: -v "\.png$"
        --filter (-e): list<string> # Only include filepaths matching this regex. For png file types: -e "\.png$"
        --file-types (-t) # show only these file types
        --terminal-width (-w): int # Specify width of output overriding the auto detection of terminal width
        --no-progress (-P) # Disable the progress indication.
        --print-errors # Print path with errors.
        --only-dir (-D) # Only directories will be displayed.
        --only-file (-F) # Only files will be displayed. (Finds your largest files)
        --output-format (-o): string@"nu-complete dust-OutputFormat" # Changes output display size.
        --stack-size (-S): int # Specify memory to use as stack size - use if you see: 'fatal runtime error: stack overflow' (default low memory=1048576, high memory=1073741824)
        --params: list<path> # Input files or directories.
        --output-json (-j) # Output the directory tree as json to the current directory
        --mtime (-M): string # +/- matches files modified more/less than n days ago, and n matches files modified exactly n days ago, days are rounded down. That is +n => (−∞, curr−(n+1)), n => [curr−(n+1), curr−n), and -n => (𝑐𝑢𝑟𝑟−𝑛, +∞)
        --atime (-A): string # just like --mtime, but based on file access time
        --ctime (-y): string # just like --mtime, but based on file change time
        --files0-from: path # run dust on NUL-terminated file names specified in file; if argument is -, then read names from standard input
        --collapse: list<string> # Keep these directories collapsed
        --filetime: string@"nu-complete dust-FileTime" # Directory 'size' is max filetime of child files instead of disk size, while a/c/m for last accessed/changed/modified time
    ]

    def "nu-complete dust-OutputFormat" []: nothing -> table<value: string, description: string> {
        [
            { value: "si", description: "SI prefix (powers of 1000)" }
            { value: "b", description: "byte (B)" }
            { value: "kib", description: "kibibyte (KiB)" }
            { value: "mib", description: "mebibyte (MiB)" }
            { value: "gib", description: "gibibyte (GiB)" }
            { value: "tib", description: "tebibyte (TiB)" }
            { value: "kb", description: "kilobyte (KB)" }
            { value: "mb", description: "megabyte (MB)" }
            { value: "gb", description: "gigabyte (GB)" }
            { value: "tb", description: "terabyte (TB)" }
        ]
    }

    def "nu-complete dust-FileTime" []: nothing -> table<value: string, description: string> {
        [
            { value: "accessed", description: "last accessed time" }
            { value: "a", description: "last accessed time" }

            { value: "changed", description: "last changed time" }
            { value: "c", description: "last changed time" }

            { value: "modified", description: "last modified time" }
            { value: "m", description: "last modified time" }
        ]
    }
}

export use completions *
