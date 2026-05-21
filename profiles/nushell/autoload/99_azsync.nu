if (which azsync | is-not-empty) {
    let autoload_dir = $nu.data-dir | path join "vendor" "autoload"
    mkdir $autoload_dir
    azsync completions nushell | save -f ($autoload_dir | path join "azsync.nu")
}
