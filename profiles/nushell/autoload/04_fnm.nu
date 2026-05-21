# Ensure fnm is installed
if (which fnm | is-not-empty) {
    # Load environment variables
    fnm env --json | from json | load-env

    # Update env
    let multishell_path = if $nu.os-info.name == "windows" {
        $env.FNM_MULTISHELL_PATH
    } else {
        $env.FNM_MULTISHELL_PATH | path join "bin"
    }
    $env.PATH = $env.PATH | prepend $multishell_path

    # Update npm version on cd if needed
    $env.config.hooks = $env.config.hooks
    | merge deep --strategy append {
        env_change: {
            PWD: [{
                condition: {
                    const FILES = [".node-version", ".nvmrc", "package.json"]
                    $FILES | any { path exists }
                }
                code: {
                    fnm use --install-if-missing --silent-if-unchanged --version-file-strategy recursive --corepack-enabled
                }
            }]
        }
    }
}
