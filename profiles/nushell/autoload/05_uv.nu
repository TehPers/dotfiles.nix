if (which uv | is-not-empty) {
    let autoload_dir = $nu.data-dir | path join "vendor" "autoload"
    mkdir $autoload_dir
    uv generate-shell-completion nushell | save -f ($autoload_dir | path join "uv.nu")
    uvx --generate-shell-completion nushell | save -f ($autoload_dir | path join "uvx.nu")
}
